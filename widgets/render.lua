local renderElements = {}
local function getTableName(tbl)
    for k, v in pairs(_G) do
        if v == tbl then
            return k
        end
    end
    return nil
end

Render = Class({
    constructor = function(self, table)
        local index = getTableName(table);
        print(index)
        self.data = table[1];
        renderElements[renderId] = {rt=self.renderTarget, position=table[2]};
        return renderId;
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