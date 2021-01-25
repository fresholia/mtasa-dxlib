local tocolor = tocolor

local function foo()
    -- ** Exporting lib class:
    lib.drawRectangle(25, 25, 250, 250, tocolor(255, 0, 0))

    -- ** Non table-based function:
    libs:loadNonOOPFunctions()
    drawRectangle(25, 25, 250, 250, tocolor(255, 0, 0))
end

foo()