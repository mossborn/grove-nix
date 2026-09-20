# ~/nixos/modules/desktop.nix
{ inputs, pkgs, username, dotfiles, ... }:

{
  imports = [
    inputs.noctalia.nixosModules.default
    inputs.noctalia-greeter.nixosModules.default
  ];

  nixpkgs.overlays = [ inputs.helium-flake.overlays.default
                       inputs.sonora.overlays.default ];

  # ---------- Compositor ----------
  programs.hyprland = {
    enable = true;             # also sets up xdg-desktop-portal-hyprland
    xwayland.enable = true;
  };

  # ---------- Shell + login screen ----------
  programs.noctalia.enable = true;   # started from hyprland.lua, not systemd

  services.displayManager.noctalia-greeter = {
    enable = true;                   # enables greetd and points it at the greeter
    settings = {
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 24;
        path = "${pkgs.bibata-cursors}/share/icons";
      };
      keyboard.layout = "us";
    };
  };

  # ---------- Portals, keyring, auth, mounts ----------
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];   # GTK file pickers
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;       # unlock at login
  security.polkit.enable = true;
  services.gvfs.enable = true;       # trash, phones, network shares in Nautilus
  services.udisks2.enable = true;    # USB drive mounting

  environment.sessionVariables.NIXOS_OZONE_WL = "1";   # Electron apps on Wayland

  # ---------- GTK look without home-manager ----------
  # A system dconf database: dark mode, theme, icons, cursor for GTK/libadwaita apps.
  programs.dconf = {
    enable = true;
    profiles.user.databases = [{
      settings."org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        gtk-theme = "adw-gtk3-dark";
        icon-theme = "Papirus-Dark";
        cursor-theme = "Bibata-Modern-Ice";
      };
    }];
  };

  # ---------- Fonts ----------
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    inter
    nerd-fonts.jetbrains-mono
  ];

  # ---------- Desktop apps ----------
  environment.systemPackages = with pkgs; [
    kitty nautilus file-roller loupe mpv pavucontrol
    wl-clipboard playerctl brightnessctl
    adw-gtk3 papirus-icon-theme bibata-cursors
    helium vesktop adwaita-icon-theme uwsm
    sonora
  ];

  # ---------- Dotfiles, the no-home-manager way ----------
  # L+ replaces whatever is there with a symlink into the repo.
  systemd.tmpfiles.rules = [
    "d  /home/${username}/.config          0755 ${username} users - -"
    "L+ /home/${username}/.config/hypr     -    -           -     - ${dotfiles}/hypr"
    "L+ /home/${username}/.config/noctalia -    -           -     - ${dotfiles}/noctalia"
  ];
}
