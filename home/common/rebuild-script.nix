{
  writeShellApplication,
  git,
  nixfmt,
  hostname,
  system,
}:
let
  args."x86_64-linux" = {
    rebuild = "sudo nixos-rebuild switch --flake .#${hostname}";
    listGens = "nixos-rebuild list-generations";
  };
  args."aarch64-darwin" = {
    rebuild = "sudo darwin-rebuild switch --flake .#${hostname}";
    listGens = "sudo darwin-rebuild --list-generations";
  };
in
writeShellApplication {
  name = "nix-rebuild";
  runtimeInputs = [
    git
    nixfmt
  ];
  text = with args.${system}; ''
    update=0
    for arg in "$@"; do
      case "$arg" in
        -u|--update) update=1 ;;
        *) echo "Usage: nix-rebuild [-u|--update]"; exit 1 ;;
      esac
    done

    cd ~/nix-config
    startHead=$(git rev-parse HEAD)

    echo "Fetching..."
    git fetch
    if git rev-parse --abbrev-ref '@{u}' >/dev/null 2>&1; then
      behind=$(git rev-list --count 'HEAD..@{u}')
      if [[ $behind -gt 0 ]]; then
        git log --oneline 'HEAD..@{u}'
        read -p "Pull $behind new commit(s)? [Y/n] " -n 1 -r; echo
        if [[ ! $REPLY =~ ^[Nn]$ ]]; then
          git pull --ff-only
        fi
      fi
    fi

    if [[ $update -eq 1 ]]; then
      echo "Updating flake inputs..."
      nix flake update
    fi

    "''${EDITOR:-vi}" .

    mapfile -t nixFiles < <(git ls-files --cached --others --exclude-standard '*.nix')
    nixfmt "''${nixFiles[@]}"

    if [[ $(git rev-parse HEAD) == "$startHead" && -z $(git status --porcelain) ]]; then
      read -p "No changes. Rebuild anyway? [y/N] " -n 1 -r; echo
      if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 0
      fi
    fi

    git add -A

    echo "Rebuilding..."
    ${rebuild} --show-trace
    echo "Rebuild OK!"

    if git diff --cached --quiet; then
      echo "Nothing to commit"
      exit 0
    fi

    gen=$(${listGens} | grep current | awk '{print $1}')
    git diff --cached --stat --patch
    read -p "Commit message: " -r msg
    if [[ -n $msg ]]; then
      git commit -m "$msg [gen $gen]"
    else
      git commit -m "gen $gen"
    fi

    read -p "Push? [y/N] " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      git push
    fi
  '';
}
