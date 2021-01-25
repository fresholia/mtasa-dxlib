local tocolor = tocolor

local function foo()
    -- ** Exporting lib class:

    local window = lib.drawWindow(25, 25, 500, 500, "foo")

    lib.drawRectangle(25, 25, 250, 250, tocolor(255, 0, 0))
        .on("click",
            function()
            
            end
        )
        .on("mouseIn",
            function()
            
            end
        )
        .visible(true)
        .parent(window)
        .destroy()

    -- ** OR
    local rect = lib.drawRectangle(25, 25, 250, 250, tocolor(255, 0, 0))
    rect.visible(true)
    rect.on("click",
        function()
        
        end
    )

    -- ** Non table-based function:
    lib:loadNonOOPFunctions()
    local rect = drawRectangle(25, 25, 250, 250, tocolor(255, 0, 0))
    on("click", rect,
        function()
        
        end
    )
end

foo()