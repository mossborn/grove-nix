# ~/nixos/modules/dev.nix
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    godot          # Godot 4, GDScript. Use godot-mono instead for C#
    blender        # 3D models and animation (blender-hip for GPU Cycles on AMD)
    krita          # textures and 2D art
    pixelorama     # pixel art
    audacity       # sound effects
    vscodium       # install "godot-tools" from its extension panel
    renderdoc      # GPU frame debugger
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;      # large binary assets
  };

  programs.direnv = {
    enable = true;          # hooks into fish automatically
    nix-direnv.enable = true;
  };
}
