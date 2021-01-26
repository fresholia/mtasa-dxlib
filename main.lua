lib = new("lib")
    .details = {
        project = "Luna",
        author = "github.com/cleopatradev",
        repo = "github.com/cleopatradev/mta-dxlib",
        contributors = "", --** Please add yourself if you contribute the project.
        collaborators = "cleopatradev"
    }

local addEventHandler = addEventHandler

function lib.prototype.____constructor()
    self.elements = {}
    self.parents = {}

    self.options = {}
end

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        load(lib)
        lib:loadlibs()
        lib:renderer()
    end
)