local tocolor = tocolor

local function foo()
    -- ** Exporting lib class:
    lib.drawRectangle(25, 25, 250, 250, tocolor(255, 0, 0))
        .on("click",
            function()
            
            end
        )
        .on("mouseIn",
            function()
            
            end
        )

    -- ** Non table-based function:
    libs:loadNonOOPFunctions()
    local rect = drawRectangle(25, 25, 250, 250, tocolor(255, 0, 0))
    on("click", rect,
        function()
        
        end
    )
end

foo()