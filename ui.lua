buttons = {}
activeButton = false

local inputLineGetStart = {}
local inputLineGetInverse = {}

local inputCursorState = false
local lastChangeCursorState = 0

local repeatTimer = false
local repeatStartTimer = false

fakeInputs = {}
selectedInput = false

function drawInput(key, label, x, y, sx, sy, font, fontScale, a, textColor)
    a = a or 1

    if not fakeInputs[key] then
        fakeInputs[key] = ""
    end

    dxDrawRectangle(x, y, sx, sy, tocolor(0, 0, 0, 75 * a))

    local borderColor

    if selectedInput == key then
        borderColor = {colorInterpolation("input:" .. key, 117, 117, 117, 255)}
    elseif activeButton == "input:" .. key then
        borderColor = {colorInterpolation("input:" .. key, 117, 117, 117, 255)}
    else
        borderColor = {colorInterpolation("input:" .. key, 75, 75, 75, 255)}
    end

    if selectedInput == key then
        if not inputLineGetStart[key] then
            inputLineGetInverse[key] = false
            inputLineGetStart[key] = getTickCount()
        end
    elseif inputLineGetStart[key] then
        inputLineGetInverse[key] = getTickCount()
        inputLineGetStart[key] = false
    end

    local lineProgress = 0

    if inputLineGetStart[key] then
        local elapsedTime = getTickCount() - inputLineGetStart[key]
        local progress = elapsedTime / 300

        lineProgress = interpolateBetween(
            0, 0, 0,
            1, 0, 0,
            progress, "Linear")
    elseif inputLineGetInverse[key] then
        local elapsedTime = getTickCount() - inputLineGetInverse[key]
        local progress = elapsedTime / 300

        lineProgress = interpolateBetween(
            1, 0, 0,
            0, 0, 0,
            progress, "Linear")
    end

    lineProgress = sx / 2 * lineProgress

    local activeColor = tocolor(36, 119, 159, 255 * a)
    dxDrawRectangle(x, y + sy - 2, sx, 2, tocolor(borderColor[1], borderColor[2], borderColor[3], borderColor[4] * a))
    dxDrawRectangle(x + sx / 2, y + sy - 2, -lineProgress, 2, activeColor)
    dxDrawRectangle(x + sx / 2, y + sy - 2, lineProgress, 2, activeColor)

    sy = sy - 2

    if utf8.len(fakeInputs[key]) > 0 then
        dxDrawText(fakeInputs[key], x + 3, y, x + sx - 3, y + sy, textColor, fontScale, font, "left", "center", true)
    elseif label then
        dxDrawText(label, x + 3, y, x + sx - 3, y + sy, textColor, fontScale, font, "left", "center", true)
    end

    if selectedInput == key then
        if inputCursorState then
            local contentSizeX = dxGetTextWidth(fakeInputs[key], fontScale, font)

            dxDrawLine(x + 3 + contentSizeX, y + 5, x + 3 + contentSizeX, y + sy - 5, tocolor(230, 230, 230, 255 * a))
        end

        if getTickCount() - lastChangeCursorState >= 500 then
            inputCursorState = not inputCursorState
            lastChangeCursorState = getTickCount()
        end
    end

    buttons["input:" .. key] = {x, y, sx, sy}
end

function drawButton(key, text, x, y, w, h, r, g, b, a, font, fontScale, alwaysActive, disable, icon, iconFont, iconScale)
    local buttonR, buttonG, buttonB, buttonA
    local borderR, borderG, borderB

    a = a or 1
    font = font or "default-bold"
    fontScale = fontScale or 1

    if activeButton == "btn:" .. key or alwaysActive and not disable then
        if getKeyState("mouse1") then
            buttonR, buttonG, buttonB, buttonA = colorInterpolation("btn:" .. key, r, g, b, 200, 250)
        else
            buttonR, buttonG, buttonB, buttonA = colorInterpolation("btn:" .. key, r, g, b, 255)
        end

        borderR, borderG, borderB = colorInterpolation("btnBorder:" .. key, r, g, b, 255)
    else
        buttonR, buttonG, buttonB, buttonA = colorInterpolation("btn:" .. key, 59, 59, 59, 255)
        borderR, borderG, borderB = colorInterpolation("btnBorder:" .. key, 117, 117, 117, 255)
    end

    local borderColor = tocolor(borderR, borderG, borderB, 255 * a)

    dxDrawRectangle(x + 1, y + 2, w - 2, h - 4, tocolor(buttonR, buttonG, buttonB, buttonA * a))
    dxDrawRectangle(x, y, w, 2, borderColor)
    dxDrawRectangle(x, y + h - 2, w, 2, borderColor)
    dxDrawRectangle(x - 1, y + 1, 2, h - 2, borderColor)
    dxDrawRectangle(x + w - 1, y + 1, 2, h - 2, borderColor)

    if not icon then
        dxDrawText(text, x, y, x + w, y + h, tocolor(255, 255, 255, 255 * a), fontScale, font, "center", "center")
    elseif not iconFont then
        iconScale = iconScale or h - 5

        local iconWidth = iconScale + 10
        local textWidth = dxGetTextWidth(text, fontScale, font)
        local labelStartX = x + (w - (iconWidth + textWidth)) / 2

        dxDrawImage(math.floor(labelStartX), math.floor(y + (h - iconScale) / 2), iconScale, iconScale, icon, 0, 0, 0, tocolor(255, 255, 255, 255 * a))
        dxDrawText(text, labelStartX + iconWidth, y, 0, y + h, tocolor(255, 255, 255, 255 * a), fontScale, font, "left", "center")
    elseif iconFont then
        iconScale = iconScale or fontScale

        local iconWidth = dxGetTextWidth(icon, iconScale, iconFont) + 10
        local textWidth = dxGetTextWidth(text, iconScale, font)
        local labelStartX = x + (w - (iconWidth + textWidth)) / 2

        dxDrawText(icon, labelStartX, y, 0, y + h, tocolor(255, 255, 255, 255 * a), iconScale, iconFont, "left", "center")
        dxDrawText(text, labelStartX + iconWidth, y, 0, y + h, tocolor(255, 255, 255, 255 * a), fontScale, font, "left", "center")
    end

    buttons["btn:" .. key] = {x, y, w, h}
end

function drawButton2(key, text, x, y, w, h, r, g, b, a, font, fontScale, icon, iconFont, iconScale)
    local buttonR, buttonG, buttonB, buttonA

    if activeButton == key then
        if getKeyState("mouse1") then
            buttonR, buttonG, buttonB, buttonA = colorInterpolation(key, r, g, b, 200, 250)
        else
            buttonR, buttonG, buttonB, buttonA = colorInterpolation(key, r, g, b, 175)
        end
    else
        buttonR, buttonG, buttonB, buttonA = colorInterpolation(key, r, g, b, 125)
    end

    local alphaDifference = 175 - buttonA

    dxDrawRectangle(x, y, w, h, tocolor(buttonR, buttonG, buttonB, (175 - alphaDifference) * a))

    local marginColor = tocolor(buttonR, buttonG, buttonB, (125 + alphaDifference) * a)

    dxDrawLine(x, y, x + w, y, marginColor, 2)
    dxDrawLine(x, y + h, x + w, y + h, marginColor, 2)
    dxDrawLine(x, y, x, y + h, marginColor, 2)
    dxDrawLine(x + w, y, x + w, y + h, marginColor, 2)

    font = font or "default-bold"
    fontScale = fontScale or 1

    if not text and icon then
        iconScale = iconScale or fontScale

        dxDrawText(icon, x, y, x + w, y + h, tocolor(255, 255, 255, 255 * a), iconScale, iconFont, "center", "center")
    elseif not icon then
        dxDrawText(text, x, y, x + w, y + h, tocolor(255, 255, 255, 255 * a), fontScale, font, "center", "center")
    elseif not iconFont then
        iconScale = iconScale or h - 5

        local iconWidth = iconScale + 10
        local textWidth = dxGetTextWidth(text, fontScale, font)
        local labelStartX = x + (w - (iconWidth + textWidth)) / 2

        dxDrawImage(math.floor(labelStartX), math.floor(y + (h - iconScale) / 2), iconScale, iconScale, icon, 0, 0, 0, tocolor(255, 255, 255, 255 * a))
        dxDrawText(text, labelStartX + iconWidth, y, 0, y + h, tocolor(255, 255, 255, 255 * a), fontScale, font, "left", "center")
    elseif iconFont then
        iconScale = iconScale or fontScale

        local iconWidth = dxGetTextWidth(icon, iconScale, iconFont) + 10
        local textWidth = dxGetTextWidth(text, iconScale, font)
        local labelStartX = x + (w - (iconWidth + textWidth)) / 2

        dxDrawText(icon, labelStartX, y, 0, y + h, tocolor(255, 255, 255, 255 * a), iconScale, iconFont, "left", "center")
        dxDrawText(text, labelStartX + iconWidth, y, 0, y + h, tocolor(255, 255, 255, 255 * a), fontScale, font, "left", "center")
    end

    buttons[key] = {x, y, w, h}
end

local colorInterpolationValues = {}
local lastColorInterpolationValues = {}
local colorInterpolationTicks = {}

function colorInterpolation(key, r, g, b, a, duration)
    if not colorInterpolationValues[key] then
        colorInterpolationValues[key] = {r, g, b, a}
        lastColorInterpolationValues[key] = r .. g .. b .. a
    end

    if lastColorInterpolationValues[key] ~= (r .. g .. b .. a) then
        lastColorInterpolationValues[key] = r .. g .. b .. a
        colorInterpolationTicks[key] = getTickCount()
    end

    if colorInterpolationTicks[key] then
        local progress = (getTickCount() - colorInterpolationTicks[key]) / (duration or 500)
        local red, green, blue = interpolateBetween(colorInterpolationValues[key][1], colorInterpolationValues[key][2], colorInterpolationValues[key][3], r, g, b, progress, "Linear")
        local alpha = interpolateBetween(colorInterpolationValues[key][4], 0, 0, a, 0, 0, progress, "Linear")

        colorInterpolationValues[key][1] = red
        colorInterpolationValues[key][2] = green
        colorInterpolationValues[key][3] = blue
        colorInterpolationValues[key][4] = alpha

        if progress >= 1 then
            colorInterpolationTicks[key] = false
        end
    end

    return colorInterpolationValues[key][1], colorInterpolationValues[key][2], colorInterpolationValues[key][3], colorInterpolationValues[key][4]
end

local corner = dxCreateTexture("assets/images/corner.png", "argb", true, "clamp")

function dxDrawRoundedRectangle(x, y, w, h, color, radius, postGUI, subPixelPositioning)
	radius = radius or 5
	color = color or tocolor(0, 0, 0, 200)
	
	dxDrawImage(x, y, radius, radius, corner, 0, 0, 0, color, postGUI)
	dxDrawImage(x, y + h - radius, radius, radius, corner, 270, 0, 0, color, postGUI)
	dxDrawImage(x + w - radius, y, radius, radius, corner, 90, 0, 0, color, postGUI)
	dxDrawImage(x + w - radius, y + h - radius, radius, radius, corner, 180, 0, 0, color, postGUI)
	
	dxDrawRectangle(x, y + radius, radius, h - radius * 2, color, postGUI, subPixelPositioning)
	dxDrawRectangle(x + radius, y, w - radius * 2, h, color, postGUI, subPixelPositioning)
	dxDrawRectangle(x + w - radius, y + radius, radius, h - radius * 2, color, postGUI, subPixelPositioning)
end
    
function isInSlot(xS, yS, wS, hS)
    if(isCursorShowing()) then
        local cursorX, cursorY = getCursorPosition()
        cursorX, cursorY = cursorX*screenX, cursorY*screenY
        if(cursorX >= xS and cursorX <= xS+wS and cursorY >= yS and cursorY <= yS+hS) then
            return true
        else
            return false
        end
    end	
end