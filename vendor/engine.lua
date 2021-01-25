lib.engine = new("lib.engine")


function lib.engine.prototype.____constructor()
    self.events = {}

    self.validEvents = {
        ["hover"] = true,
        ["unhover"] = true,
        ["removed"] = true,
    }
    return true
end

--[[
    **lib.engine:type()
    **  Example:
    **      if lib.engine:type(element) == "window" then
--]]
function lib.engine.prototype.type(self)

    return true
end

--[[
    **lib.engine:on()
    **  Non-oop event listener
    **  Example:
    **      In-resource:
    **          lib.engine:on("hover", element, callbackFunction)
    **      Out-resource:
    **          lib:on("hover", element, callbackFunction)
--]]
function lib.engine.prototype.on(self, eventName, element, callback)
    if self.validEvents[eventName] then

    end
    return true
end

--[[
    **lib.engine:loadEvents
    **  In-resource only function
    **  Loads OOP element listener events
    **  Example:
    **      In/Out-resource:
    **          element.on("hover", callbackFunction)
]]--
function lib.engine.prototype.loadEvents(self, element)
    local events = {}

    events.on = function(eventName, callback)
        if self.validEvents[eventName] then
            
        end

        return events
    end

    return events
end