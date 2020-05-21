local lastButtonID = 0

function createButton(x, y, w, h, name, parent)
	assert(tonumber(x), "Bad argument @createButton at argument 1, expect number got " .. type(x))
	assert(tonumber(y), "Bad argument @createButton at argument 2, expect number got " .. type(y))
	assert(tonumber(w), "Bad argument @createButton at argument 3, expect number got " .. type(w))
    assert(tonumber(h), "Bad argument @createButton at argument 4, expect number got " .. type(h))
    
    lastButtonID = lastButtonID + 1
    LocalDocument:push("Button.create("..lastButtonID..", "..x..", "..y..", "..w..", "..h..", '"..(name or "").."', '"..parent.."');")

    return "button-"..lastButtonID
end