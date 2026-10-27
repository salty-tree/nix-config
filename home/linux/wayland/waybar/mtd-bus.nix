{
  config,
  pkgs,
  ...
}:
let
  stopId = "GRNBUSEY:8";
  stopIdSafe = builtins.replaceStrings [ ":" ] [ "_" ] stopId;
  minInterval = 65; # seconds

  secretsFile = "${config.xdg.configHome}/waybar/secrets.env";
  cacheFile = "${config.xdg.cacheHome}/mtd-waybar/${stopIdSafe}.json";

  mtd-waybar = pkgs.writeShellScriptBin "mtd-waybar" ''
    set -euo pipefail

    if [[ -f "${secretsFile}" ]]; then
      set -a
      source "${secretsFile}"
      set +a
    fi

    if [[ -z "''${MTD_API_KEY:-}" ]]; then
      echo '{"text":"NOKEY","tooltip":"MTD_API_KEY not set in secrets.env"}'
      exit 0
    fi

    CACHE_FILE="${cacheFile}"
    mkdir -p "$(dirname "$CACHE_FILE")"

    now=$(date +%s)

    should_fetch=true
    if [[ -f "$CACHE_FILE" ]]; then
      mtime=$(stat -c %Y "$CACHE_FILE" 2>/dev/null || stat -f %m "$CACHE_FILE")
      age=$((now - mtime))
      if (( age < ${toString minInterval} )); then
        should_fetch=false
      fi
    fi

    if $should_fetch; then
      url="https://api.mtd.dev/stops/${stopId}/departures"

      response=$(${pkgs.curl}/bin/curl -s --max-time 10 -H "X-ApiKey: $MTD_API_KEY" "$url" || true)

      if [[ -n "$response" ]] && echo "$response" | ${pkgs.jq}/bin/jq -e '.error == null and (.result | type == "array")' >/dev/null 2>&1; then
        echo "$response" > "$CACHE_FILE"
      fi
    fi

    if [[ ! -f "$CACHE_FILE" ]]; then
      echo '{"text":"N/A","tooltip":"No data available"}'
      exit 0
    fi

    data=$(cat "$CACHE_FILE")

    # Pick the first departure that hasn't left yet (the cache may be up to a minute old)
    idx=-1
    mins=0
    i=0
    while IFS= read -r est; do
      est_epoch=$(date -d "$est" +%s)
      if (( est_epoch >= now )); then
        idx=$i
        mins=$(( (est_epoch - now) / 60 ))
        break
      fi
      i=$((i + 1))
    done < <(echo "$data" | ${pkgs.jq}/bin/jq -r '.result[].estimatedDeparture')

    if (( idx < 0 )); then
      echo '{"text":"—","tooltip":"No upcoming departures"}'
      exit 0
    fi

    departure=$(echo "$data" | ${pkgs.jq}/bin/jq -c ".result[$idx]")
    route_long_name=$(echo "$departure" | ${pkgs.jq}/bin/jq -r '.route.longName')
    route_name=$(echo "$route_long_name" | grep -oE '\b\w' | tr -d '\n')
    route_num=$(echo "$departure" | ${pkgs.jq}/bin/jq -r '.route.shortName')
    direction=$(echo "$departure" | ${pkgs.jq}/bin/jq -r '.trip.direction.shortName')

    mtime=$(stat -c %Y "$CACHE_FILE" 2>/dev/null || stat -f %m "$CACHE_FILE")
    last_updated=$(date -d "@$mtime" +%H:%M 2>/dev/null || date -r "$mtime" +%H:%M)

    text="''${route_num}''${direction} ''${route_name} in ''${mins}min"
    tooltip="Last updated ''${last_updated}"

    ${pkgs.jq}/bin/jq -c -n --arg text "$text" --arg tooltip "$tooltip" \
      '{text:$text, tooltip:$tooltip}'
  '';
in
{
  programs.waybar.settings.mainbar."custom/mtd_bus" = {
    exec = "${mtd-waybar}/bin/mtd-waybar";
    interval = 10;
    return-type = "json";
  };
}
