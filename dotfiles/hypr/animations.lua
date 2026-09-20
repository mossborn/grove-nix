-- Omarchy's animation set: short, eased bezier curves, a subtle "popin" for
-- windows, plain fades for layers, and no workspace slide.
-- Beziers only (no springs), so nothing here changes between Hyprland releases.

hl.config({ animations = { enabled = true } })

---------------- CURVES ----------------
hl.curve("easeOutQuint",   { type = "bezier", points = { { 0.23, 1 },    { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear",         { type = "bezier", points = { { 0, 0 },       { 1, 1 } } })
hl.curve("almostLinear",   { type = "bezier", points = { { 0.5, 0.5 },   { 0.75, 1 } } })
hl.curve("quick",          { type = "bezier", points = { { 0.15, 0 },    { 0.1, 1 } } })

---------------- ANIMATIONS ----------------
-- speed is in deciseconds: 4.1 = 410 ms. Lower is faster.
local function anim(leaf, speed, bezier, style)
  hl.animation({ leaf = leaf, enabled = true, speed = speed, bezier = bezier, style = style })
end

anim("global",        10,   "default")
anim("border",        5.39, "easeOutQuint")

anim("windows",       4.79, "easeOutQuint")
anim("windowsIn",     4.1,  "easeOutQuint", "popin 87%")
anim("windowsOut",    1.49, "linear",       "popin 87%")

anim("fadeIn",        1.73, "almostLinear")
anim("fadeOut",       1.46, "almostLinear")
anim("fade",          3.03, "quick")

anim("layers",        3.81, "easeOutQuint")
anim("layersIn",      4,    "easeOutQuint", "fade")
anim("layersOut",     1.5,  "linear",       "fade")
anim("fadeLayersIn",  1.79, "almostLinear")
anim("fadeLayersOut", 1.39, "almostLinear")

-- Omarchy switches workspaces instantly. For a quick slide instead, replace
-- the line below with:  anim("workspaces", 3, "easeOutQuint", "slide")
hl.animation({ leaf = "workspaces", enabled = false })
