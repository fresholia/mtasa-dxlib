screenX, screenY = guiGetScreenSize()

reMap = function(x, in_min, in_max, out_min, out_max)
	return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end
responsiveMultipler = reMap(screenX, 1024, 1920, 0.75, 1)

resp = function(num)
	return num * responsiveMultipler
end

loadFonts = function()
	fonts = {
        Roboto = dxCreateFont("assets/fonts/Roboto-Regular.ttf", resp(10), false, "antialiased"),
        RobotoS = dxCreateFont("assets/fonts/Roboto-Regular.ttf", resp(9), false, "antialiased"),
        RobotoXS = dxCreateFont("assets/fonts/Roboto-Regular.ttf", resp(8), false, "antialiased"),
		RobotoB = dxCreateFont("assets/fonts/Roboto-Bold.ttf", resp(12), false, "antialiased"),
		FontAwesome = dxCreateFont("assets/fonts/FontAwesome.ttf", resp(10), false, "cleartype"),
		RobotoL = dxCreateFont("assets/fonts/Roboto-Light.ttf", resp(12), false, "antialiased")
	}
	for k,v in pairs(fonts) do
		_G[k] = v
		_G[k .. "H"] = dxGetFontHeight(1, _G[k])
	end
end
addEventHandler("onClientResourceStart", resourceRoot, loadFonts)
loadFonts()

reMap = function(x, in_min, in_max, out_min, out_max)
	return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end

render = function()
    buttons = {}
    for i=1, #ConvertCache do
        local row = ConvertCache[i]
        if row then
            row.render(row)
        end
    end
end
addEventHandler("onClientRender", root, render, true, "low-99")