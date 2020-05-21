local lastWindowID = 0

function createWindow(x, y, w, h, name, parent)
    assert(type(LocalDocument) == "table", "Bad argument @LocalDocument at argument 1, expect element, create firstly")
	assert(tonumber(x), "Bad argument @createWindow at argument 1, expect number got " .. type(x))
	assert(tonumber(y), "Bad argument @createWindow at argument 2, expect number got " .. type(y))
	assert(tonumber(w), "Bad argument @createWindow at argument 3, expect number got " .. type(w))
    assert(tonumber(h), "Bad argument @createWindow at argument 4, expect number got " .. type(h))
    
    lastWindowID = lastWindowID + 1
    LocalDocument:push("Window.create("..lastWindowID..", "..x..", "..y..", "..w..", "..h..", '"..(name or "").."');")

    return "window-"..lastWindowID, "window-"..lastWindowID.."-title", "window-"..lastWindowID.."-body"
end