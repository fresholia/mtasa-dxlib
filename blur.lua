local blurShaders = {}
local myScreenSource = dxCreateScreenSource(screenX, screenY)

function createBlur(name, strenght, pos)
	if strenght > 15 then strenght = 15 end
	if not pos then pos = false end
	blurShaders[#blurShaders + 1] = {s_name = name, shader = dxCreateShader("assets/shaders/BlurShader.fx"), strenght_s = strenght, pos = pos}
end

function removeBlur(name)
	for k, v in ipairs(blurShaders) do
		if v.s_name == name then
			table.remove(blurShaders, k)
			return
		end
	end
end

addEventHandler("onClientRender", root,
	function()
		for k, v in ipairs(blurShaders) do
			if v.shader then
				dxUpdateScreenSource(myScreenSource)
				
				dxSetShaderValue(v.shader, "screenSource", myScreenSource)
				dxSetShaderValue(v.shader, "screenSize", {screenX, screenY})
				dxSetShaderValue(v.shader, "blurStrength", 3)
				dxSetShaderValue(v.shader, "alpha", 1)
				dxSetShaderValue(v.shader, "colorize", 53/255, 59/255, 72/255)
				if v.pos then
					dxDrawImageSection(v.pos.x, v.pos.y, v.pos.w, v.pos.h, v.pos.x, v.pos.y, v.pos.w, v.pos.h, v.shader)
				else
					dxDrawImage(0, 0, screenX, screenY, v.shader)
				end
			end
		end
	end
)