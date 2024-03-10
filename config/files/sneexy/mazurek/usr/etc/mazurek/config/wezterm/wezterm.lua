local wezterm = require 'wezterm';
local config = wezterm.config_builder()

config.front_end = 'WebGpu'

config.font = wezterm.font 'JetBrainsMono NF'
config.freetype_load_target = 'Normal'
config.font_size = 11

config.window_background_opacity = 1
config.enable_scroll_bar = true
config.window_padding = {
  left = 11,
  right = 11,
  top = 11,
  bottom = 11,
}
config.window_frame = {
  font = wezterm.font { family = 'Lexend', weight = 'Bold' },
  font_size = 10,
  active_titlebar_bg = '#1e1e2e',
  inactive_titlebar_bg = '#1e1e2e',
}

config.colors = {
  tab_bar = {
    background = '#1e1e2e',
    inactive_tab_edge = '#181825',
    active_tab = {
      bg_color = '#a6e3a1',
      fg_color = '#1e1e2e',
      italic = true,
    },
    inactive_tab = {
      bg_color = '#181825',
      fg_color = '#cdd6f4',
    },
    inactive_tab_hover = {
      bg_color = '#11111b',
      fg_color = '#cdd6f4',
      italic = false,
    },
    new_tab = {
      bg_color = '#11111b',
      fg_color = '#cdd6f4',
      italic = false,
    },
    new_tab_hover = {
      bg_color = '#74c7ec',
      fg_color = '#1e1e2e',
      italic = false,
    },
  },
}

config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.enable_scroll_bar = false

config.color_scheme = 'Catppuccin Mocha'

config.default_cursor_style = 'BlinkingBar'
config.animation_fps = 60

return config
