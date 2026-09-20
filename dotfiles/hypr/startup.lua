---------------- ENVIRONMENT ----------------
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

---------------- AUTOSTART ----------------
-- Runs once per session, not on every reload
hl.on("hyprland.start", function()
  hl.exec_cmd("noctalia")
end)
