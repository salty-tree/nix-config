{
  pkgs,
  ...
}:
{
  nixpkgs.config.rocmSupport = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.amdgpu.opencl.enable = true;

  environment.systemPackages = with pkgs; [
    libva
    libva-utils
    mesa
  ];

  services.xserver.videoDrivers = [ "amdgpu" ];
}
