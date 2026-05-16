{ ... }:
{
  programs.git = {
    enable = true;

    signing.format = null;

    settings = {
      user.name = "Daniel Gu";
      user.email = "bobthebuilder10492@gmail.com";
      init.defaultBranch = "main";
    };
  };
}
