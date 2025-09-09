local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Global settings
config.automatically_reload_config = true
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.adjust_window_size_when_changing_font_size = false
config.max_fps = 120
config.animation_fps = 120
config.front_end = "WebGpu"
config.prefer_egl = true
config.enable_kitty_graphics = true
config.window_close_confirmation = "NeverPrompt"
config.audible_bell = "Disabled"

-- Font settings
-- config.font = wezterm.font("CommitMono Nerd Font")
config.font = wezterm.font("BlexMono Nerd Font")
-- config.font = wezterm.font("Lilex")
config.harfbuzz_features = { "liga=1", "calt=1", "ss02=1", "ss04=1" }
config.font_size = 17

-- Appearance
config.color_scheme_dirs = { wezterm.config_dir .. "/.config/wezterm/colors/" }
config.color_scheme = "duskfox"
config.window_padding = {
	left = 15,
	right = 15,
	top = 20,
	bottom = 10,
}

return config
