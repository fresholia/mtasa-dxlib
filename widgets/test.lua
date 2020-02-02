--[[
    IMPORTING OOP CLASSES:
        exports.resourcename:import("*")
        exports.resourcename:import("Window, Webview, Button")
]]--

import("*")

Apps = {}

Apps.Window = Window({x=0, y=0, w=350, h=350, name="Test Window", parent=false, effects={blur=true}})

Apps.Rectangle = Button({x=5, y=5, w=200, h=25, name="Test Button", parent=Apps.Window})

Render({Apps, {x=500, y=250, w=350, h=350}});