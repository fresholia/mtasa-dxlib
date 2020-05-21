function testAllElements()
    local window, header, body = createWindow(450, 150, 512, 512, "test window", false)

    local button = createButton(25, 25, 250, 25, "click me", body)
end

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        testAllElements()
    end
)