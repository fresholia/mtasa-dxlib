function setElementProperty(element, data, value)
    assert(type(LocalDocument) == "table", "Bad argument @LocalDocument at argument 1, expect element, create firstly")
    LocalDocument:push("setProperty('"..element.."', '"..data.."', '"..value.."');")
    return true
end