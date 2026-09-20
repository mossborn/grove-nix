# ~/nixos/hosts/nixbox/configuration.nix
{ pkgs, inputs, username, hostname, ... }:

{
  # Generated on the target machine by nixos-generate-config; not in git until first install.
  imports = [ ./hardware-configuration.nix ];

  # ---------- Boot ----------
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;   # keeps the ESP from filling up
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-zen4;
  
  # boot.kernelPackages = pkgs.linuxPackages_latest;     # newest amdgpu fixes

  # ---------- btrfs ----------
  # Adds to the subvol= options already in hardware-configuration.nix
  fileSystems =
    let opts = [ "compress=zstd" "noatime" ];
    in {
      "/".options        = opts;
      "/home".options    = opts;
      "/nix".options     = opts;
      "/var/log".options = opts;
      "/games".options   = opts;
    };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];   # one path per btrfs filesystem is enough
  };

  # Hourly /home snapshots, kept for a week (uses /home/.snapshots)
  services.snapper.configs.home = {
    SUBVOLUME = "/home";
    ALLOW_USERS = [ username ];
    TIMELINE_CREATE = true;
    TIMELINE_CLEANUP = true;
    TIMELINE_LIMIT_HOURLY = 12;
    TIMELINE_LIMIT_DAILY = 7;
    TIMELINE_LIMIT_WEEKLY = 2;
    TIMELINE_LIMIT_MONTHLY = 0;
    TIMELINE_LIMIT_YEARLY = 0;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  # ---------- AMD CPU + GPU ----------
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;          # required by Steam and Proton
  };
  hardware.amdgpu.initrd.enable = true;   # load amdgpu early, clean greeter start
  # services.lact.enable = true;          # optional GUI for fan curves / power limits

  # ---------- Networking, Bluetooth, power ----------
  networking.hostName = hostname;
  networking.networkmanager.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.fwupd.enable = true;           # firmware updates via fwupdmgr

  # ---------- Locale ----------  <-- CHANGE ME
  time.timeZone = "America/Denver";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  # ---------- Audio (PipeWire) ----------
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # ---------- User ----------
  programs.fish.enable = true;
  programs.fish.shellAbbrs = {
    rebuild = "sudo nixos-rebuild switch --flake ~/nixos";
    update  = "nix flake update --flake ~/nixos && sudo nixos-rebuild switch --flake ~/nixos";
  };
  users.users.${username} = {
    isNormalUser = true;
    uid = 1000;                          # fixed so the install step can chown the repo
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "input" "gamemode" ];
    shell = pkgs.fish;
  };

  # ---------- Nix ----------
  nixpkgs.config.allowUnfree = true;     # Steam, fonts, etc.
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    extra-substituters = [ "https://noctalia.cachix.org" "https://attic.xuyh0120.win/lantian" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    ];
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  environment.systemPackages = with pkgs; [
    git gh vim wget curl unzip file
    btop microfetch pciutils usbutils
  ];

  # Keep the value your generated configuration.nix had. Never bump it later.
  system.stateVersion = "26.05";
}
