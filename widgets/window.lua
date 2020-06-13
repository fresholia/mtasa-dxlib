local lastWindowID = 0

Window = setmetatable({
    constructor = function(self, x, y, w, h, name, parent)
        assert(type(LocalDocument) == "table", "Bad argument @LocalDocument at argument 1, expect element, create firstly")
        assert(tonumber(x), "Bad argument @Window at argument 1, expect number got " .. type(x))
        assert(tonumber(y), "Bad argument @Window at argument 2, expect number got " .. type(y))
        assert(tonumber(w), "Bad argument @Window at argument 3, expect number got " .. type(w))
        assert(tonumber(h), "Bad argument @Window at argument 4, expect number got " .. type(h))
        
        local parent = parent and parent.id or false
        lastWindowID = lastWindowID + 1
        LocalDocument:push("Window.create("..lastWindowID..", "..x..", "..y..", "..w..", "..h..", '"..(name or "").."');")

        self.index = lastWindowID
        self.id = "window-"..lastWindowID.."-body"
        return self
    end;
    create = function(self)
     
        return self
    end;
}, {
__call = function(cls, ...)
    local self = {}
    setmetatable(self, {
        __index = cls
    })

    self:constructor(...)

    return self
end
})