local renderElements = {}

Render = Class({
    constructor = function(self, table)
        local renderId = #renderElements + 1;
        self.renderTarget = dxCreateRenderTarget(table[2].w, table[2].h, true)
        self.data = table[1];
        self:prepare();
        renderElements[renderId] = {rt=self.renderTarget, position=table[2]};
        return renderId;
    end;

    prepare = function(self)
        dxSetRenderTarget(self.renderTarget, true)
        dxSetBlendMode("modulate_add")

        for id, row in ipairs(self.data) do
            if row.type == "Window" then
                dxDrawRectangle(row.position.x, row.position.y, row.position.w, row.position.h, tocolor(25, 25, 25))
            end
        end

        dxSetRenderTarget()
    end;

    update = function(self, renderId)

    end;
})

renderAll = function()
    for id, row in ipairs(renderElements) do
        if row then
            dxDrawImage(row.position.x, row.position.y, row.position.w, row.position.h, row.rt)
        end
    end
end;
addEventHandler("onClientRender", root, renderAll, true, "low-99")