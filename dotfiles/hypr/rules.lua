---------------- WORKSPACES ----------------
-- Keep workspaces 1-5 visible in Noctalia's bar even when empty
for i = 1, 5 do
  hl.workspace_rule({ workspace = tostring(i), persistent = true })
end

---------------- WINDOWS ----------------
hl.window_rule({
  name  = "noctalia-settings",
  match = { class = "dev.noctalia.Noctalia" },
  float = true,
  size  = { 1080, 920 },
})

hl.window_rule({
  name  = "float-utils",
  match = { class = "^(org.pulseaudio.pavucontrol|nm-connection-editor)$" },
  float = true,
})

-- Games may tear when fullscreen: lowest input latency
hl.window_rule({ name = "steam-games", match = { class = "^steam_app_.*" }, immediate = true })
hl.window_rule({ name = "gamescope",   match = { class = "^gamescope$" },   immediate = true })

-- From the upstream example config
hl.window_rule({ name = "suppress-maximize", match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({
  name  = "fix-xwayland-drags",
  match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
  no_focus = true,
})

---------------- LAYERS ----------------
-- Blur behind Noctalia's surfaces. no_anim keeps the layer animations in
-- animations.lua off them, since Noctalia animates its own panels.
hl.layer_rule({
  name  = "noctalia",
  match = { namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$" },
  no_anim      = true,
  ignore_alpha = 0.5,
  blur         = true,
  blur_popups  = true,
})
