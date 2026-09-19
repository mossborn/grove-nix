# nixos

My NixOS config. Flakes, btrfs, Hyprland + Noctalia.

## Layout

- `flake.nix` - inputs, username, hostname
- `hosts/` - system config and hardware config
- `modules/` - desktop, gaming, dev
- `dotfiles/` - hyprland and noctalia configs, linked into `~/.config`

## Usage

Rebuild after changes:

    sudo nixos-rebuild switch --flake ~/nixos

Update:

    nix flake update --flake ~/nixos
    sudo nixos-rebuild switch --flake ~/nixos

Roll back:

    sudo nixos-rebuild switch --rollback

New files need `git add` before rebuilding.

## Fresh install

1. Partition, format btrfs, create subvolumes `@ @home @nix @log @games`, mount to `/mnt`.
2. `nixos-generate-config --root /mnt`
3. Clone this repo to `/mnt/home/moss/nixos` and copy `/mnt/etc/nixos/hardware-configuration.nix` into the host folder.
4. `nixos-install --flake /mnt/home/moss/nixos#grove`
5. `nixos-enter --root /mnt -c 'passwd moss'`
6. `chown -R 1000:100 /mnt/home/moss`, then reboot.
