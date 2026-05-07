{
  self,
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/amdgpu.nix
    ../../modules/copyparty.nix
    ../../modules/docker.nix
    ../../modules/xdg.nix
    ../../modules/kanata
    ../../modules/minecraft
    ../../modules/reverse_tunnel.nix
    ../common.nix
  ];

  nixpkgs.overlays = [
    (final: prev: {
      # Requires an old version of Nvidia something or something
      opencv = prev.opencv.override { enableCuda = false; };
      discord = prev.discord.override { withTTS = true; };
    })
  ];

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 20;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  # OBS virtual cam
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS VCam" exclusive_caps=1
  '';
  security.polkit.enable = true;

  networking.hostName = "fwd-nixos";
  # networking.interfaces.enp6s0.useDHCP = true;
  networking.networkmanager.enable = true;
  networking.hosts = {
    # "192.168.100.200" = [ "pzn.local" ];
    # "192.168.100.1" = [ "ddwrt.local" ];
    # "223.166.245.202" = [ "home" ];
  };

  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];

  time.hardwareClockInLocalTime = true;

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-chinese-addons
      fcitx5-rime
      fcitx5-hangul
    ];
  };

  # X11/GNOME
  # services.xserver = {
  #   enable = true;
  #   xkb = {
  #     layout = "us";
  #     variant = "";
  #   };
  #   #wacom.enable = true;
  #
  #   desktopManager.gnome.enable = true;
  #   displayManager.gdm.enable = true;
  # };
  #
  # services.displayManager.defaultSession = "gnome-xorg";

  services.libinput.mouse = {
    accelProfile = "flat";
    middleEmulation = false;
    scrollButton = 3;
  };

  services.minecraft-tunnel = {
    enable = true;
    vpsIp = "64.23.232.63";
    vpsUser = "ssh_tunnel";
    vpsPort = 8000;
    localPort = 8000;
    user = "danielgu";
    identityFile = "/home/danielgu/.ssh/vps_tunnel_key";
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      inter
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      corefonts
    ];
    fontconfig.defaultFonts = {
      monospace = [ "JetBrainsMono NFM" ];
      sansSerif = [
        "Inter"
        "Noto Sans CJK SC"
        "Noto Sans CJK KR"
        "Noto Sans CJK JP"
      ];
      serif = [
        "DejaVu Serif"
        "Noto Serif CJK SC"
        "Noto Serif CJK KR"
        "Noto Serif CJK JP"
      ];
    };
    fontDir.enable = true;
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [ epson-escpr ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.cloudflared = {
    enable = true;
  };

  services.ollama.enable = true;

  services.udev.packages = with pkgs; [ wooting-udev-rules ];

  # Pipewire sound
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  programs.dconf.enable = true;
  # services.jack = {
  #   jackd.enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  # };

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  users.users.danielgu = {
    isNormalUser = true;
    description = "Daniel Gu";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "adbusers"
      "copyparty"
      "jackaudio"
      "minecraft"
      "vboxusers"
    ];
    shell = pkgs.nushell;
  };

  home-manager = {
    extraSpecialArgs = { inherit self inputs; };
    users = {
      "danielgu" = import ./home.nix;
    };
  };

  hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.daemon.enable = true;
  #services.udev.extraRules = "";

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    unzip
    xclip
    nushell
  ];
  environment.variables = {
    MOZ_ENABLE_WAYLAND = 1;
    # https://github.com/Martichou/rquickshare/issues/158
    WEBKIT_DISABLE_COMPOSITING_MODE = 1;
  };
  environment.shells = [
    "/run/current-system/sw/bin/nu"
    "${pkgs.nushell}/bin/nu"
  ];

  programs.alvr = {
    enable = false;
    openFirewall = true;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libGL
    libxkbcommon
    wayland
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
  ];

  programs.steam = {
    enable = true;
    extraPackages = with pkgs; [ fuse ];
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
    protontricks.enable = true;
  };

  virtualisation.virtualbox = {
    host.enable = true;
    host.enableExtensionPack = true;
  };

  programs.hyprland.enable = true;
  # programs.wayland.miracle-wm.enable = true;
  programs.waybar.enable = true;
  services.displayManager = {
    sddm.enable = true;
    sddm.wayland.enable = true;
    defaultSession = "hyprland";
  };

  services.blueman.enable = true;

  services.openssh.enable = true;
  services.openssh.settings.X11Forwarding = true;

  # services.hardware.openrgb.enable = true;

  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "daily";

  system.stateVersion = "23.11";
}
