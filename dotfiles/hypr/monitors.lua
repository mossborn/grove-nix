-- `hyprctl monitors all` lists names and modes. Fixed example:
-- hl.monitor({ output = "DP-1", mode = "2560x1440@165", position = "0x0", scale = 1 })

hl.monitor({
  output   = "",
  mode     = "highrr",   -- highest refresh rate; use "preferred" if it misbehaves
  position = "auto",
  scale    = "auto",
  bitdepth = 10,
  cm = "srgb",
  vrr = 2,
})
