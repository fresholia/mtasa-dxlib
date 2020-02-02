local renderElements = {}

iterate = function(data)
    return math.random(1, 99999);
end;

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
        for id, row in pairs(self.data) do
            local x, y, w, h = row.position.x, row.position.y, row.position.w, row.position.h
            if row.parent then
                x, y = row.parent.position.x + x, row.parent.position.y + y
            end
            if row.effects then
                if row.effects.blur then
                    createBlur(row.id, 5, {x=x, y=y, w=w, h=h})
                end
            end
            
            if row.type == "Window" then
                dxDrawRectangle(x, y, w, h, tocolor(25, 25, 25, 200))
            elseif row.type == "Button" then
                dxDrawRectangle(x, y, w, h, tocolor(225, 225, 225))
                
            end
        end

        dxSetRenderTarget()
    end;

    update = function(self, renderId)

    end;
})

renderAll = function()
    for id, row in pairs(renderElements) do
        if row then
            dxDrawImage(row.position.x, row.position.y, row.position.w, row.position.h, row.rt)
        end
    end
end;
addEventHandler("onClientRender", root, renderAll, true, "low-99")