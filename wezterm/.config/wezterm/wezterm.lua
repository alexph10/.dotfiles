local wezterm = require 'wezterm'
local act      = wezterm.action
local config   = wezterm.config_builder and wezterm.config_builder() or {}

config.color_scheme           = 'Tokyo Night'
config.font                   = wezterm.font_with_fallback {
    { family = 'JetBrainsMono Nerd Font', weight = 'Regular' },
    { family = 'JetBrains Mono', weight = 'Regular' },
    'Symbols Nerd Font',
}
config.font_size              = 11.0
config.line_height            = 1.05
config.harfbuzz_features      = { 'calt=1', 'clig=1', 'liga=1' }
config.adjust_window_size_when_changing_font_size = false

config.use_fancy_tab_bar      = false
config.tab_bar_at_bottom      = true
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations     = 'RESIZE'
config.window_padding         = { left = 10, right = 10, top = 8, bottom = 4 }
config.window_background_opacity = 0.97
config.macos_window_background_blur = 20
config.scrollback_lines       = 50000
config.audible_bell           = 'Disabled'
config.check_for_updates      = false
config.enable_scroll_bar      = false

if wezterm.target_triple:find('windows') then
    config.default_prog = { 'pwsh.exe', '-NoLogo' }
end

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1500 }

config.keys = {
    { key = '|', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = '-', mods = 'LEADER',       action = act.SplitVertical   { domain = 'CurrentPaneDomain' } },
    { key = 'h', mods = 'LEADER',       action = act.ActivatePaneDirection 'Left' },
    { key = 'j', mods = 'LEADER',       action = act.ActivatePaneDirection 'Down' },
    { key = 'k', mods = 'LEADER',       action = act.ActivatePaneDirection 'Up' },
    { key = 'l', mods = 'LEADER',       action = act.ActivatePaneDirection 'Right' },
    { key = 'z', mods = 'LEADER',       action = act.TogglePaneZoomState },
    { key = 'c', mods = 'LEADER',       action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'x', mods = 'LEADER',       action = act.CloseCurrentPane { confirm = true } },
    { key = 'p', mods = 'LEADER',       action = act.ActivateCommandPalette },
    { key = 'f', mods = 'LEADER',       action = act.Search { CaseSensitiveString = '' } },
    { key = 'n', mods = 'CTRL|SHIFT',   action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'w', mods = 'CTRL|SHIFT',   action = act.CloseCurrentTab { confirm = true } },
}

for i = 1, 9 do
    table.insert(config.keys, { key = tostring(i), mods = 'LEADER', action = act.ActivateTab(i - 1) })
end

return config
