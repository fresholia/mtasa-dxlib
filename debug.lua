--[[
    WARNING:
        This class reflects its CPU value by selecting itself among all scripts.
        So, CPU values ​​may be high due to the CPU debugger.
]]--
local showDebug = true -- if u wanna don't show, change 'false'
local debugCache, fps = {cpu=0}, 0
local fpsTick, countFrame = getTickCount(), 0

floorNumber = function(num)
	return tonumber(string.sub(tostring(num), 0, -2)) or 0
end

prepare = function()
    _, clientRows = getPerformanceStats("Lua timing")
    table.sort(clientRows,
        function(a, b)
            return floorNumber(a[2]) > floorNumber(b[2])
        end
    )

    for i, row in ipairs(clientRows) do
        if row[1] == getResourceName(getThisResource()) then
            debugCache = {cpu=floorNumber(row[2])}
        end
    end
end
setTimer(prepare, 500, 0)

renderDebug = function()
    countFrame = countFrame + 1
    if getTickCount() - fpsTick >= 1000 then
        fps = countFrame
        countFrame = 0
        fpsTick = getTickCount()
    end
    dxDrawText("CPU Usage: %"..debugCache.cpu.." - FPS: "..fps, 0, 0, screenX, screenY-20, tocolor(255, 255, 255), 2, "default", "center", "bottom")
end
addEventHandler("onClientRender", root, renderDebug)