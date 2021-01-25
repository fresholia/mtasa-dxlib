
function lib.prototype.loadRectangleLib(self)
    self.rectangles = {}
end

function lib.prototype.loadRectangleFunctions(self)
    _G["drawRectangle"] = self.drawRectangle
end

function lib.prototype.drawRectangle(self, x, y, w, h, color)
    local linkedID = #self.elements + 1
    self.elements[linkedID] = {
        type = "rectangle",
        position = Vector2(x, y),
        size = Vector2(w, h)
        color = color
    }

    return lib.engine:loadEvents(linkedID)
end