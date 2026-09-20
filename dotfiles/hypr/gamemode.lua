-- SUPER + G: strip animations, blur, shadows and gaps for games; press again
-- to restore. Pure Lua, no scripts. Resets to "off" on every config reload.

local v = require("vars")
local gameMode = false

hl.bind(v.mainMod .. " + G", function()
  gameMode = not gameMode
  hl.config({
    animations = { enabled = not gameMode },
    decoration = {
      blur   = { enabled = not gameMode },
      shadow = { enabled = not gameMode },
    },
    general = {
      gaps_in  = gameMode and 0 or v.gaps_in,
      gaps_out = gameMode and 0 or v.gaps_out,
    },
  })
end)
