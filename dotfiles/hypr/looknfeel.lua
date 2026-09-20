-- Gaps, rounding, shadow and blur are Noctalia's recommended Hyprland values:
-- https://docs.noctalia.dev/noctalia/compositor-settings/hyprland/

local v = require("vars")

hl.config({
  general = {
    gaps_in       = v.gaps_in,
    gaps_out      = v.gaps_out,
    border_size   = 2,
    layout        = "dwindle",
    allow_tearing = true,   -- only affects windows with the `immediate` rule
  },

  decoration = {
    rounding       = 20,
    rounding_power = 2,
    shadow = {
      enabled      = true,
      range        = 4,
      render_power = 3,
      color        = 0xee1a1a1a,
    },
    blur = {
      enabled  = true,
      size     = 3,
      passes   = 2,
      vibrancy = 0.1696,
    },
  },

  dwindle = {
    preserve_split = true,
  },
})
