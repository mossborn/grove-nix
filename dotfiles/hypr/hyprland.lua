-- ~/nixos/dotfiles/hypr/hyprland.lua  (the folder is linked to ~/.config/hypr)
--
-- Entry point only. Every require() runs in its own scope, so an error in one
-- file stops that file, not the rest of the config. Paths are relative to
-- this file. Check problems with: hyprctl configerrors

require("monitors")    -- displays
require("startup")     -- environment variables + Noctalia autostart
require("looknfeel")   -- gaps, borders, rounding, blur, shadows, layout
require("animations")  -- Omarchy-style curves and timings
require("input")       -- keyboard, mouse, misc behaviour
require("rules")       -- window, layer and workspace rules
require("keybinds")    -- apps, Noctalia, windows, workspaces, media
require("gamemode")    -- SUPER + G effects toggle
require("noctalia").apply_theme()
