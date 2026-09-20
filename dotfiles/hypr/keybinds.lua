local v = require("vars")
local mod, ipc = v.mainMod, v.ipc

---------------- APPS ----------------
hl.bind(mod .. " + Return", hl.dsp.exec_cmd(v.terminal))
hl.bind(mod .. " + E",      hl.dsp.exec_cmd(v.files))
hl.bind(mod .. " + B",      hl.dsp.exec_cmd(v.browser))

---------------- NOCTALIA ----------------
hl.bind(mod .. " + Space",  hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(mod .. " + S",      hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))
hl.bind(mod .. " + V",      hl.dsp.exec_cmd(ipc .. "panel-toggle clipboard"))
hl.bind(mod .. " + W",      hl.dsp.exec_cmd(ipc .. "panel-toggle wallpaper"))
hl.bind(mod .. " + Escape", hl.dsp.exec_cmd(ipc .. "panel-toggle session"))
hl.bind(mod .. " + comma",  hl.dsp.exec_cmd(ipc .. "settings-toggle"))
hl.bind(mod .. " + L",      hl.dsp.exec_cmd(ipc .. "session lock"))
hl.bind("ALT + Tab",        hl.dsp.exec_cmd(ipc .. "window-switcher"))
hl.bind("Print",            hl.dsp.exec_cmd(ipc .. "screenshot-region"))

---------------- WINDOWS ----------------
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + P", hl.dsp.window.pseudo())
hl.bind(mod .. " + J", hl.dsp.layout("togglesplit"))

for _, dir in ipairs({ "left", "right", "up", "down" }) do
  hl.bind(mod .. " + " .. dir, hl.dsp.focus({ direction = dir }))
end

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

---------------- WORKSPACES ----------------
for i = 1, 10 do
  local key = i % 10   -- workspace 10 is on key 0
  hl.bind(mod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
  hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mod .. " + grave",         hl.dsp.workspace.toggle_special("scratch"))
hl.bind(mod .. " + SHIFT + grave", hl.dsp.window.move({ workspace = "special:scratch" }))

hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

---------------- MEDIA ----------------
-- Volume goes through Noctalia so its OSD shows
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"),   { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(ipc .. "volume-mute"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
