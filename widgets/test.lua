--[[
    IMPORTING OOP CLASSES:
        exports.resourcename:import("*")
        exports.resourcename:import("Window, Webview, Button")
]]--

import("*")

Apps = {}

Apps.Window = Window({x=0, y=0, w=350, h=350, name="Test Window", parent=false, effects={blur=true}, text="hello", color=tocolor(235, 235, 235)})

Render({Apps, {x=500, y=250, w=350, h=350}});