
local wezterm = require('wezterm')

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()

    config.automatically_reload_config = true

    -- window settings
    config.window_background_opacity = 1.0
    config.window_decorations = "RESIZE"

    -- tab settings
    config.enable_tab_bar = false
    config.show_tabs_in_tab_bar = false
    config.hide_tab_bar_if_only_one_tab = true

    -- colors
    config.colors = {
        foreground = 'white',
        background = 'black',
        cursor_fg = 'white',
        cursor_bg = 'white',
        cursor_border = 'white',
    }

    -- cursor
    config.default_cursor_style = "BlinkingBlock"
    config.animation_fps = 60
    config.cursor_blink_ease_in = 'Constant'
    config.cursor_blink_ease_out = 'Constant'
    config.cursor_blink_rate = 600
    config.cursor_thickness = 1

    -- font
    config.font = wezterm.font("Monaco", {weight="Regular", stretch="Normal", style="Normal"})
    config.font_size = 12
end

return config
