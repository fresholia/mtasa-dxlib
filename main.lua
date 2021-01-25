local lib = new("lib")
local addEventHandler = addEventHandler

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        

        load(lib)
    end
)