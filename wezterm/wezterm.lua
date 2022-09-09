local wezterm = require 'wezterm'
local act = wezterm.action

return {
    font = wezterm.font('Iosevka'),
    font_size = 10.5,
    enable_tab_bar = false,
    color_scheme = "Catppuccin Mocha",
    window_padding = {
        left = 0,
        bottom = 3,
        top = 3,
        right = 0,
    },
    -- window_background_opacity = 0.7,
    -- text_background_opacity = 1,
    keys = {
        {
            key = 'Tab',
            mods = 'CTRL',
            action = act.SendKey { key = 'Tab', mods = 'CTRL' },
        },
        {
            key = 'Tab',
            mods = 'CTRL|SHIFT',
            action = act.SendKey { key = 'Tab', mods = 'CTRL|SHIFT' },
        },
  },
}
