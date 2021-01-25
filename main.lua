lib = new("lib")

local addEventHandler = addEventHandler

function lib.prototype.____constructor()
    self.elements = {}
    self.parents = {}

    self.options = {}
end

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        lib:loadlibs()

        load(lib)
    end
)