--[[
    WARNING:
        This class reflects its CPU value by selecting itself among all scripts.
        So, CPU values ​​may be high due to the CPU debugger.
]]--
local showDebug = true -- if u wanna don't show, change 'false'
local debugCache = {cpu=0}

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
    dxDrawText("CPU Usage: %"..debugCache.cpu, 0, 0, screenX, screenY-20, tocolor(255, 255, 255), 2, "default", "center", "bottom")
end
addEventHandler("onClientRender", root, renderDebug)