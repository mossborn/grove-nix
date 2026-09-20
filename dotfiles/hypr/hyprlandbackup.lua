-- ~/nixos/dotfiles/hypr/hyprland.lua  (linked to ~/.config/hypr/hyprland.lua)

local mainMod  = "SUPER"
local terminal = "kitty"
local files    = "nautilus"
local browser  = "firefox"
local ipc      = "noctalia msg "

---------------- MONITORS ----------------
-- `hyprctl monitors all` lists names and modes. Fixed example:
-- hl.monitor({ output = "DP-1", mode = "2560x1440@165", position = "0x0", scale = 1 })
hl.monitor({
  output   = "",
  mode     = "highrr",   -- highest refresh rate; use "preferred" if it misbehaves
  position = "auto",
  scale    = "auto",
})

---------------- ENVIRONMENT ----------------
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

---------------- AUTOSTART ----------------
hl.on("hyprland.start", function()
  hl.exec_cmd("noctalia")
end)

---------------- LOOK, INPUT, MISC ----------------
hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 10,
    border_size = 2,
    layout = "dwindle",
    allow_tearing = true,          -- only for windows with the `immediate` rule
  },
  decoration = {
    rounding = 12,
    rounding_power = 2,
    shadow = { enabled = true, range = 4, render_power = 3, color = 0xee1a1a1a },
    blur   = { enabled = true, size = 3, passes = 2, vibrancy = 0.1696 },
  },
  animations = { enabled = true },
  dwindle = { preserve_split = true },
  input = {
    kb_layout = "us",
    follow_mouse = 1,
    sensitivity = 0,
    accel_profile = "flat",        -- raw mouse input for games
  },
  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,  -- Noctalia draws the wallpaper
    vrr = 2,                       -- FreeSync for fullscreen apps only
  },
})

-- Keep workspaces 1-5 visible in Noctalia's bar even when empty
for i = 1, 5 do
  hl.workspace_rule({ workspace = tostring(i), persistent = true })
end

---------------- KEYBINDS: apps + Noctalia ----------------
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(files))
hl.bind(mainMod .. " + B",      hl.dsp.exec_cmd(browser))

hl.bind(mainMod .. " + Space",  hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(mainMod .. " + S",      hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))
hl.bind(mainMod .. " + V",      hl.dsp.exec_cmd(ipc .. "panel-toggle clipboard"))
hl.bind(mainMod .. " + W",      hl.dsp.exec_cmd(ipc .. "panel-toggle wallpaper"))
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd(ipc .. "panel-toggle session"))
hl.bind(mainMod .. " + comma",  hl.dsp.exec_cmd(ipc .. "settings-toggle"))
hl.bind(mainMod .. " + L",      hl.dsp.exec_cmd(ipc .. "session lock"))
hl.bind("ALT + Tab",            hl.dsp.exec_cmd(ipc .. "window-switcher"))
hl.bind("Print",                hl.dsp.exec_cmd(ipc .. "screenshot-region"))

---------------- KEYBINDS: windows + workspaces ----------------
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

for _, dir in ipairs({ "left", "right", "up", "down" }) do
  hl.bind(mainMod .. " + " .. dir, hl.dsp.focus({ direction = dir }))
end

for i = 1, 10 do
  local key = i % 10  -- workspace 10 is on key 0
  hl.bind(mainMod .. " + " .. key,           hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key,   hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + grave",         hl.dsp.workspace.toggle_special("scratch"))
hl.bind(mainMod .. " + SHIFT + grave", hl.dsp.window.move({ workspace = "special:scratch" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272",  hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273",  hl.dsp.window.resize(), { mouse = true })

-- Media keys go through Noctalia so its OSD shows
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"),   { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(ipc .. "volume-mute"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

---------------- WINDOW + LAYER RULES ----------------
hl.window_rule({ name = "noctalia-settings", match = { class = "dev.noctalia.Noctalia" },
                 float = true, size = { 1080, 920 } })

-- Games may tear when fullscreen: lowest input latency
hl.window_rule({ name = "steam-games", match = { class = "^steam_app_.*" }, immediate = true })
hl.window_rule({ name = "gamescope",   match = { class = "^gamescope$" },   immediate = true })

hl.window_rule({ name = "float-utils",
                 match = { class = "^(org.pulseaudio.pavucontrol|nm-connection-editor)$" },
                 float = true })

-- From the upstream example
hl.window_rule({ name = "suppress-maximize", match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({ name = "fix-xwayland-drags",
                 match = { class = "^$", title = "^$", xwayland = true, float = true,
                           fullscreen = false, pin = false },
                 no_focus = true })

-- Blur behind Noctalia's bar, panels, dock and notifications
hl.layer_rule({
  name = "noctalia",
  match = { namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$" },
  no_anim = true,
  ignore_alpha = 0.5,
  blur = true,
  blur_popups = true,
})

---------------- GAME MODE (SUPER + G) ----------------
-- Pure Lua: no scripts. Kept last and wrapped in pcall so a problem here
-- can never stop the rest of the file from loading.
local gameMode = false
pcall(hl.bind, mainMod .. " + G", function()
  gameMode = not gameMode
  hl.config({
    animations = { enabled = not gameMode },
    decoration = { blur = { enabled = not gameMode }, shadow = { enabled = not gameMode } },
    general    = { gaps_in = gameMode and 0 or 5, gaps_out = gameMode and 0 or 10 },
  })
end)

-- For Noctalia Color templates
require("noctalia").apply_theme()
