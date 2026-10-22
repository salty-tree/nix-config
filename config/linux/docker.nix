{
  config,
  pkgs,
  ...
}: {
  virtualisation.docker.enable = true;
  users.users.danielgu.extraGroups = ["docker"];
}
