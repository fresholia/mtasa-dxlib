lib = new("lib")

local addEventHandler = addEventHandler

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        lib:loadlibs()

        load(lib)
    end
)