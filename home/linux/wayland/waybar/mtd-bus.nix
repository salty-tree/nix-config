{
  config,
  pkgs,
  ...
}:
let
  stopId = "GRNBUSEY:8";
  stopIdSafe = builtins.replaceStrings [ ":" ] [ "_" ] stopId;
  version = "v2.2";
  format = "json";
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
      url="https://developer.mtd.org/api/${version}/${format}/getdeparturesbystop?key=$MTD_API_KEY&stop_id=${stopId}&pt=60&count=1"

      response=$(${pkgs.curl}/bin/curl -s --max-time 10 "$url" || true)

      if [[ -n "$response" ]] && echo "$response" | ${pkgs.jq}/bin/jq -e '.status.code == 200' >/dev/null 2>&1; then
        echo "$response" > "$CACHE_FILE"
      fi
    fi

    if [[ ! -f "$CACHE_FILE" ]]; then
      echo '{"text":"N/A","tooltip":"No data available"}'
      exit 0
    fi

    data=$(cat "$CACHE_FILE")

    count=$(echo "$data" | ${pkgs.jq}/bin/jq '.departures | length')

    if [[ "$count" -eq 0 ]]; then
      echo '{"text":"—","tooltip":"No upcoming departures"}'
      exit 0
    fi

    route_long_name=$(echo "$data" | ${pkgs.jq}/bin/jq -r '.departures[0].route.route_long_name')
    route_name=$(echo "$route_long_name" | grep -oE '\b\w' | tr -d '\n')
    route_num=$(echo "$data" | ${pkgs.jq}/bin/jq -r '.departures[0].route.route_short_name')
    mins=$(echo "$data" | ${pkgs.jq}/bin/jq -r '.departures[0].expected_mins')

    mtime=$(stat -c %Y "$CACHE_FILE" 2>/dev/null || stat -f %m "$CACHE_FILE")
    last_updated=$(date -d "@$mtime" +%H:%M 2>/dev/null || date -r "$mtime" +%H:%M)

    text="''${route_num}W ''${route_name} in ''${mins}min"
    tooltip="Last updated ''${last_updated}"

    ${pkgs.jq}/bin/jq -c -n --arg text "$text" --arg tooltip "$tooltip" \
      '{text:$text, tooltip:$tooltip}'
  '';
in
{
  programs.waybar.settings.mainbar."custom/mtd_bus" = {
    exec = "${mtd-waybar}/bin/mtd-waybar";
    interval = minInterval;
    return-type = "json";
  };
}
