function testAllElements()
    local window = Window(450, 150, 512, 512, "test window", false)

    Button(25, 25, 250, 25, "click me", window)
end

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        testAllElements()
    end
)