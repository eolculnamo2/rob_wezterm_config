local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action
local mux = wezterm.mux

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 14.0
config.color_scheme = 'Ashes (base16)'
config.native_macos_fullscreen_mode = true

config.keys = {
    {
        key = 'n',
        -- mods = 'CTRL|SHIFT', example of key combo
        mods = 'SUPER',
        action = act.PromptInputLine {
            description = 'Enter new name for tab',
            action = wezterm.action_callback(function(window, pane, line)
                -- line will be `nil` if they hit escape without entering anything
                -- An empty string if they just hit enter
                -- Or the actual line of text they wrote
                if line then
                    window:active_tab():set_title(line)
                else
                    window:active_tab():set_title("Derp")
                end
            end),
        },
    },
    {
        key = 'd',
        mods = 'SUPER',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'w',
        mods = 'SUPER',
        action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    { key = 'h', mods = 'SUPER|SHIFT', action = act.ActivateTabRelative(-1) },
    { key = 'l', mods = 'SUPER|SHIFT', action = act.ActivateTabRelative(1) },
    {
        key = 'LeftArrow',
        mods = 'SUPER|SHIFT',
        action = act.ActivatePaneDirection 'Left',
    },
    {
        key = 'RightArrow',
        mods = 'SUPER|SHIFT',
        action = act.ActivatePaneDirection 'Right',
    },
    {
        key = 'UpArrow',
        mods = 'SUPER|SHIFT',
        action = act.ActivatePaneDirection 'Up',
    },
    {
        key = 'DownArrow',
        mods = 'SUPER|SHIFT',
        action = act.ActivatePaneDirection 'Down',
    },
}

wezterm.on("gui-startup", function()
    local tab, pane, window = mux.spawn_window {}
    window:gui_window():maximize()
end)

return config
