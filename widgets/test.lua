--[[
    IMPORTING OOP CLASSES:
        exports.resourcename:import("*")
        exports.resourcename:import("Window, Webview, Button")
]]--

import("*")

Apps = {
    Window({x=0, y=0, w=350, h=350, name="Test Window", parent=false}),
}

Render({Apps, {x=0, y=0, w=350, h=350}});

