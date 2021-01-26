local addEventHandler = addEventHandler

function lib.prototype.renderer(self)
    addEventHandler("onClientRender", root, self.render, true, "low-555")
end

local function lib.prototype.render()
    local self = lib.prototype
    if table.maxn(self.elements) > 0 then
        for elementID, data in ipairs(self.elements) do
            if data.type == "rectangle" and data.visible then
                dxDrawRectangle(data.position, data.size, data.color)
            end
        end
    end
end