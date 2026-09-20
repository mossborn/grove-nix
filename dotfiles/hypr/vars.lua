-- Shared values. Other files load them with: local v = require("vars")

return {
  mainMod  = "SUPER",
  terminal = "kitty",
  files    = "nautilus",
  browser  = "helium",
  ipc      = "noctalia msg ",

  -- Used by looknfeel.lua and restored by gamemode.lua
  gaps_in  = 5,
  gaps_out = 10,
}
