local lastButtonID = 0

Button = setmetatable({
    constructor = function(self, x, y, w, h, name, parent)
        assert(type(LocalDocument) == "table", "Bad argument @LocalDocument at argument 1, expect element, create firstly")
        assert(tonumber(x), "Bad argument @Button at argument 1, expect number got " .. type(x))
        assert(tonumber(y), "Bad argument @Button at argument 2, expect number got " .. type(y))
        assert(tonumber(w), "Bad argument @Button at argument 3, expect number got " .. type(w))
        assert(tonumber(h), "Bad argument @Button at argument 4, expect number got " .. type(h))
        
        local parent = parent and parent.id or false
        lastButtonID = lastButtonID + 1
        LocalDocument:push("Button.create("..lastButtonID..", "..x..", "..y..", "..w..", "..h..", '"..(name or "").."', '"..parent.."');")

        self.id = "button-"..lastButtonID
        self.index = lastButtonID
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