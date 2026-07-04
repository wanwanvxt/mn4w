local hyprConfigDir = _G.hyprConfigDir or "~/.config/hypr"

local mainMod = _G.mainMod or "SUPER"

local terminal    = _G.terminal or ""
local browser     = _G.browser or ""
local fileManager = _G.fileManager or ""

local hyprScriptsDir = hyprConfigDir .. "/scripts"

local brightnessctl = _G.brightnessctl or "brightnessctl"
local wpctl         = _G.wpctl or "wpctl"
local playerctl     = _G.playerctl or "playerctl"
local hyprshot      = _G.hyprshot or "hyprshot"

---@param ... any
---@return string
local keys = function(...)
    local args = {...}

    for i = 1, #args do
        args[i] = tostring(args[i])
    end

    return table.concat(args, "+")
end

---@param routes table
local dispatchRouteLayouts = function(routes)
    local ws = hl.get_active_workspace()
    if ws then
        local cb = routes[ws.tiled_layout]
        if cb then
            hl.dispatch(cb)
        end
    end
end

---@param offset number
local magnifier = function(offset)
    local current = hl.get_config("cursor.zoom_factor")
    if offset == nil then offset = 0 end

    local value = current + offset
    value = math.max(1, value)

    hl.config({ cursor = { zoom_factor = value } })
end

-- workspace bindings
hl.bind(keys(mainMod, "GRAVE"), hl.dsp.workspace.toggle_special())
for i = 1, 10 do
    local k = i % 10
    hl.bind(keys(mainMod, k), hl.dsp.focus({ workspace = i }))
end
hl.bind(keys(mainMod, "COMMA"),  hl.dsp.focus({ workspace = "e-1" }), { repeating = true })
hl.bind(keys(mainMod, "PERIOD"), hl.dsp.focus({ workspace = "e+1" }), { repeating = true })

-- window bindings
hl.bind(keys(mainMod, "ESCAPE"),   hl.dsp.window.close())
hl.bind(keys("ALT", "F4"),         hl.dsp.window.close())
hl.bind(keys(mainMod, "F"),        hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(keys(mainMod, "ALT", "F"), hl.dsp.window.fullscreen_state({ internal = 0, client = 2, action = "toggle" }))
hl.bind(keys(mainMod, "D"),        hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(keys(mainMod, "V"),        hl.dsp.window.float())
hl.bind(keys(mainMod, "C"),        hl.dsp.window.pin())
--# focus
hl.bind(keys(mainMod, "H"), hl.dsp.focus({ direction = "l" }), { repeating = true })
hl.bind(keys(mainMod, "J"), hl.dsp.focus({ direction = "d" }), { repeating = true })
hl.bind(keys(mainMod, "K"), hl.dsp.focus({ direction = "u" }), { repeating = true })
hl.bind(keys(mainMod, "L"), hl.dsp.focus({ direction = "r" }), { repeating = true })
hl.bind(keys("ALT", "TAB"), function()
    hl.dispatch(hl.dsp.window.cycle_next({ next = true }))
    hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end, { repeating = true })
--# resize
hl.bind(keys(mainMod, "LEFT"), function()
    dispatchRouteLayouts({
        dwindle = hl.dsp.window.resize({ x = -50, y = 0, relative = true }),
        scrolling = hl.dsp.layout("colresize -conf"),
    })
end, { repeating = true })
hl.bind(keys(mainMod, "RIGHT"), function()
    dispatchRouteLayouts({
        dwindle = hl.dsp.window.resize({ x = 50, y = 0, relative = true }),
        scrolling = hl.dsp.layout("colresize +conf"),
    })
end, { repeating = true })
hl.bind(keys(mainMod, "UP"), function()
    dispatchRouteLayouts({
        dwindle = hl.dsp.window.resize({ x = 0, y = -50, relative = true }),
    })
end, { repeating = true })
hl.bind(keys(mainMod, "DOWN"), function()
    dispatchRouteLayouts({
        dwindle = hl.dsp.window.resize({ x = 0, y = 50, relative = true }),
    })
end, { repeating = true })
--#
hl.bind(keys(mainMod, "mouse:272"), hl.dsp.window.drag(), { mouse = true })
hl.bind(keys(mainMod, "mouse:273"), hl.dsp.window.resize(), { mouse = true })
--# move
hl.bind(keys(mainMod, "SHIFT", "GRAVE"), hl.dsp.window.move({ workspace = "special" }))
for i = 1, 10 do
    local k = i % 10
    hl.bind(keys(mainMod, "SHIFT", k), hl.dsp.window.move({ workspace = i }))
end
hl.bind(keys(mainMod, "SHIFT", "COMMA"),  hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(keys(mainMod, "SHIFT", "PERIOD"), hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(keys(mainMod, "SHIFT", "H"), hl.dsp.window.move({ direction = "l", group_aware = true }))
hl.bind(keys(mainMod, "SHIFT", "J"), hl.dsp.window.move({ direction = "d", group_aware = true }))
hl.bind(keys(mainMod, "SHIFT", "K"), hl.dsp.window.move({ direction = "u", group_aware = true }))
hl.bind(keys(mainMod, "SHIFT", "L"), hl.dsp.window.move({ direction = "r", group_aware = true }))
--# group
hl.bind(keys(mainMod, "G"),            hl.dsp.group.toggle())
hl.bind(keys(mainMod, "ALT", "G"),     hl.dsp.group.lock())
hl.bind(keys("ALT", "GRAVE"),          hl.dsp.group.next(), { repeating = true })
--# layout
hl.bind(keys(mainMod, "F1"), function()
    hl.config({ general = { layout = "scrolling" } })
end)
hl.bind(keys(mainMod, "F2"), function()
    hl.config({ general = { layout = "dwindle" } })
end)

-- default apps
hl.bind(keys(mainMod, "T"), hl.dsp.exec_cmd(hyprScriptsDir .. "/spawn " .. terminal))
hl.bind(keys(mainMod, "B"), hl.dsp.exec_cmd(hyprScriptsDir .. "/spawn " .. browser))
hl.bind(keys(mainMod, "E"), hl.dsp.exec_cmd(hyprScriptsDir .. "/spawn " .. fileManager))

-- media
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(brightnessctl .. " --class=backlight set 2%+"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(brightnessctl .. " --class=backlight set 2%-"), { repeating = true, locked = true })
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd(wpctl .. " set-volume @DEFAULT_AUDIO_SINK@ 2%+ -l 1"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd(wpctl .. " set-volume @DEFAULT_AUDIO_SINK@ 2%-"),      { repeating = true, locked = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd(wpctl .. " set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { repeating = true, locked = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd(wpctl .. " set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { repeating = true, locked = true })
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd(playerctl .. " play-pause"), { repeating = true, locked = true })
hl.bind("XF86AudioStop",         hl.dsp.exec_cmd(playerctl .. " stop"),       { repeating = true, locked = true })
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd(playerctl .. " previous"),   { repeating = true, locked = true })
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd(playerctl .. " next"),       { repeating = true, locked = true })
--#
hl.bind("PRINT",               hl.dsp.exec_cmd(hyprshot .. " -m active -m output"))
hl.bind(keys("ALT", "PRINT"),  hl.dsp.exec_cmd(hyprshot .. " -m active -m window"))
hl.bind(keys("CTRL", "PRINT"), hl.dsp.exec_cmd(hyprshot .. " -z -m region"))

-- misc
hl.bind(keys(mainMod, "MINUS"),      function() magnifier(-0.2) end, { repeating = true })
hl.bind(keys(mainMod, "EQUAL"),      function() magnifier(0.2) end, { repeating = true })
hl.bind(keys(mainMod, "mouse_up"),   function() magnifier(-0.2) end)
hl.bind(keys(mainMod, "mouse_down"), function() magnifier(0.2) end)
