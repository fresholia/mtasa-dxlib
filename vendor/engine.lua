lib.engine = new("lib.engine")

function lib.engine.prototype.____constructor()
    self.events = {}

    self.validEvents = {
        ["mouseIn"] = true,
        ["mouseOut"] = true,
        ["remove"] = true,
        ["click"] = true
    }
    return true
end

--[[
    **lib.engine:parent()
    **  Get/set parent element
    **  Example:
    **      lib.engine:parent(element)
    **      lib.engine:parent(element, anotherElement)
]]--
function lib.engine.prototype.parent(self, element, parent)
    local element = self.elements[element]
    if parent then  --**SET

    else            --**GET

    end
end

--[[
    **lib.engine:type()
    **  Example:
    **      if lib.engine:type(element) == "window" then
--]]
function lib.engine.prototype.type(self, element)
    local element = self.elements[element]
    return true
end

--[[
    **lib.engine:destroy
    **  Example:
    **      lib.engine:destroy(element)
    **  OOP:
    **      element:destroy()
--]]
function lib.engine.prototype.destroy(self, element)
    local libSelf = lib.prototype
    table.remove(libSelf.elements, element)
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
    local element = self.elements[element]
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
    element.on = function(eventName, callback)
        if self.validEvents[eventName] then
            
        end

        return element
    end

    element.destroy = self:destroy
    element.parent = self:parent

    return element
end