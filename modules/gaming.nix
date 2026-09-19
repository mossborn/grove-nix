# ~/nixos/modules/gaming.nix
{ pkgs, username, ... }:

{
  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];   # shows up as a Proton option
    gamescopeSession.enable = true;                 # console-style "Steam" session in the greeter
    protontricks.enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.gamescope.enable = true;    # leave capSysNice off; it breaks launching from Steam

  programs.gamemode.enable = true;
  users.groups.gamemode = { };         # harmless if the module already defines it

  environment.systemPackages = with pkgs; [
    mangohud       # FPS / frametime overlay
    protonup-qt    # extra Proton / Wine builds
    heroic         # Epic, GOG, Amazon
    lutris         # everything else
  ];

  # hardware.xpadneo.enable = true;   # uncomment for Xbox controllers over Bluetooth

  # The @games subvolume, owned by you
  systemd.tmpfiles.rules = [ "d /games 0755 ${username} users - -" ];
}
