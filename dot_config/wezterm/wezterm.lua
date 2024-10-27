-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration
local config = wezterm.config_builder()

config = {
	adjust_window_size_when_changing_font_size = false,
	automatically_reload_config = true,
	check_for_updates = false,
	enable_tab_bar = false,
	color_scheme = 'Catppuccin Mocha',
	default_cursor_style = "SteadyBar",
	font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Bold" }),
	font_size = 16.0,
	macos_window_background_blur = 30,
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = false,
	window_background_opacity = 0.9,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE", -- disable the title bar but enable the resizable border
	window_padding = {
		left = 7,
		right = 7,
		top = 7,
		bottom = 7,
	},
}
-- return the configuration to wezterm
return config
