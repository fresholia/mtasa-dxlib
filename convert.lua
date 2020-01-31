--[[
    WARNING: The class is not ready now.
    The converter is have renderTarget & update screen problems.
    Don't use it for now.
    -------------------------------
    Don't care about file layout :S 
]]--
ConvertCache = {}
local UI = Class({
    constructor = function(self, args)
        local window =  args;
        local panelX, panelY = guiGetPosition(args, false)
        local panelW, panelH = guiGetSize(args, false)
        local GuiTree = getElementChildren(args)
        guiWindowSetMovable(window, false)
        guiSetAlpha(window, 0)
        guiWindowSetSizable(window, false)
        self.window = window;
        self.renderTarget = dxCreateRenderTarget(panelW, panelH, true)
        self.position = {x=panelX, y=panelY, w=panelW, h=panelH}
        self.blurId = math.random(1,999999)
        self.renderElements = false
        self.tick = getTickCount()

        self.mode = "dark" -- DEFAULT: dark/light
        
        if #GuiTree > 0 then
            self.renderElements = {}
            for id, element in ipairs(GuiTree) do
                self.renderElements[element] = {parents={}, id=math.random(1,999)};
                local childrens = getElementChildren(element)
                for _, children in ipairs(childrens) do
                    self.renderElements[children] = {parents={}, father={element}, id=math.random(1,999)};
                    self.renderElements[element].parents[children] = {parents={}, id=math.random(1,999)}
                    local childrens = getElementChildren(children)
                    for _, child in ipairs(childrens) do
                        self.renderElements[child] = {parents={}, father={children, element}, id=math.random(1,999)};
                        self.renderElements[element].parents[children].parents[child] = {parents={}, id=math.random(1,999)}
                    end
                end
            end
        end
        createBlur(self.blurId, 6, self.position)
        dxSetTestMode("none")
        self:prepare()
        
        return self;
    end;

    prepare = function(self)
        dxSetRenderTarget(self.renderTarget, true)
        dxSetBlendMode("modulate_add")
        if self.mode == "dark" then
            --> Background
            dxDrawRectangle(0, 0, self.position.w, self.position.h, tocolor(30, 30, 30, 240))
            --> Header
            dxDrawRectangle(0, 0, self.position.w, 35, tocolor(35, 35, 35, 240))
            dxDrawLine(0, 35, self.position.w, 35, tocolor(35, 35, 35), 2)
            dxDrawText(self.window.text, 0, 0, self.position.w, 35, tocolor(255, 255, 255), 1, RobotoL, "center", "center")
            dxDrawText("", self.position.x-5, 0, self.position.w-10, 35, tocolor(255, 255, 255, 200), 1, FontAwesome, "right", "center")
            primaryColor = tocolor(255, 255, 255)
            sr, sg, sb = 25, 25, 25
            tr, tg, tb = 35, 35, 35
            alpha = 1
        else
             --> Background
             dxDrawRectangle(0, 0, self.position.w, self.position.h, tocolor(30, 30, 30, 100))
             --> Header
             dxDrawRectangle(0, 0, self.position.w, 35, tocolor(35, 35, 35, 100))
             dxDrawLine(0, 35, self.position.w, 35, tocolor(135, 135, 135, 100), 2)
             dxDrawText(self.window.text, 0, 0, self.position.w, 35, tocolor(25, 25, 25), 1, RobotoL, "center", "center")
             dxDrawText("", self.position.x-5, 0, self.position.w-10, 35, tocolor(255, 255, 255), 1, FontAwesome, "right", "center")
             primaryColor = tocolor(25, 25, 25)
             sr, sg, sb = 225, 225, 225
             tr, tg, tb = 235, 235, 235
             alpha = 2.2
        end
        local paddingX, paddingY = 0, 0
        if self.renderElements then
            for element, data in pairs(self.renderElements) do
                local x, y = guiGetPosition(element, false)
                local visible = guiGetVisible(element)
                if data.father then
                    for i, father in ipairs(data.father) do
                        local x_, y_ = guiGetPosition(father, false)
                        x, y = x+x_, y+y_
                        if visible ~= true then
                            visible = guiGetVisible(father)
                        end
                        if father.type == "gui-tab" and not father:getData("vertical") then
                            local parent = getElementParent(father)
                            if guiGetSelectedTab(parent) ~= father then
                                visible = false
                                break
                            end
                            y = y + 25
                        end
                    end
                end
                local w, h = guiGetSize(element, false)
                local y = y + paddingY
                local id = data.id
                local parents = data.parents

                local realX, realY = self.position.x+x, self.position.y+y
                if visible then
                    if element.type == "gui-tabpanel" then
                        if element:getData("vertical") then
                            dxDrawRectangle(x, y, w, h-25, tocolor(sr, sg, sb, 230/alpha), false)
                            local subtabY = 0
                            dxDrawLine(x, y, x, y+h-25, tocolor(tr, tg, tb), 2)
                            local textWidth = 70
                            local x = x - 70
                            for parent, var in pairs(parents) do
                                dxDrawRectangle(x, y+subtabY, textWidth, 25, tocolor(sr, sg, sb, 230/alpha))
                                dxDrawText(parent.text, x, y+subtabY, textWidth+(x), 25+y+subtabY, primaryColor, 1, RobotoS, "center", "center")
                                if guiGetSelectedTab(element) == parent then
                                    dxDrawLine(x, y+subtabY, x, y+subtabY+25, tocolor(0, 168, 255, 200), 1)
                                end
                                subtabY = subtabY + 27
                            end
                        else
                            dxDrawRectangle(x, y+25, w, h-25, tocolor(sr, sg, sb, 230/alpha), false)
                            local subtabX = 0
                            dxDrawLine(x, y+25, x+w, y+25, tocolor(tr, tg, tb, 255/alpha), 2)
                            for parent, var in pairs(parents) do
                                local textWidth = dxGetTextWidth(parent.text, 1, Roboto) + 17
                                dxDrawRectangle(x+subtabX, y, textWidth, 25, tocolor(sr, sg, sb, 230/alpha))
                                dxDrawText(parent.text, x+subtabX, y, textWidth+(x+subtabX), 25+y, primaryColor, 1, RobotoS, "center", "center")
                                if guiGetSelectedTab(element) == parent then
                                    dxDrawLine(x+subtabX, y+25, x+subtabX+textWidth, y+25, tocolor(0, 168, 255, 200), 2)
                                end
                                subtabX = subtabX + textWidth + 2
                            end
                        end
                      
                    elseif element.type == "gui-label" then
                        dxDrawText(element.text, x, y, w, h, primaryColor, 1, Roboto, "left", "top")
                    elseif element.type == "gui-button" then
                        drawButton(id, element.text, x, y, w, h, 52, 152, 219, 1, Roboto, 1, false, element.disabled)
                    
                        if isInSlot(realX, realY, w, h) then
                            for k, v in pairs(buttons) do
                                if "btn:"..k == id then
                                    activeButton = k
                                end
                            end
                        end
                    elseif element.type == "gui-checkbox" then
                        dxDrawRoundedRectangle(x, y, 16, 16, tocolor(tr, tg, tb, 200))
                        if guiCheckBoxGetSelected(element) then
                            dxDrawRoundedRectangle(x+2, y+2, 12, 12, tocolor(0, 168, 255, 200))
                        end
                        dxDrawText(element.text, x+20, y, w, h, primaryColor, 1, Roboto, "left", "top")
                    elseif element.type == "gui-radiobutton" then
                        dxDrawRoundedRectangle(x, y, 16, 16, tocolor(tr, tg, tb, 200))
                        if guiRadioButtonGetSelected(element) then
                            dxDrawRoundedRectangle(x+2, y+2, 12, 12, tocolor(0, 168, 255, 200))
                        end
                        dxDrawText(element.text, x+20, y, w, h, primaryColor, 1, Roboto, "left", "top")
                    elseif element.type == "gui-scrollbar" then
                        dxDrawRectangle(x, y, w, h, tocolor(tr, tg, tb, 200/alpha))
                        dxDrawRectangle(x, y, 24, h, tocolor(tr, tg, tb, 200/alpha))
                        dxDrawRectangle(x+w-24, y, 24, h, tocolor(tr, tg, tb, 200/alpha))
                        dxDrawText("", x, y-1, 24+x, y+h-1, primaryColor, 1, FontAwesome, "center", "center")
                        dxDrawText("", x+w-24, y-1, x+w, y+h-1, primaryColor, 1, FontAwesome, "center", "center")
                        local width = guiScrollBarGetScrollPosition(element) * (w-(48+24)) / 100
                        dxDrawRectangle(x+24+width, y, 24, h, tocolor(0, 168, 255, 200))
                    elseif element.type == "gui-edit" then
                        drawInput(id, element.text, x, y, w, h, Roboto, 1, 1, primaryColor)
                    elseif element.type == "gui-progressbar" then
                        dxDrawRectangle(x, y, w, h, tocolor(tr, tg, tb, 200/alpha))
                        local width = guiProgressBarGetProgress(element) * w / 100
                        dxDrawRectangle(x, y, width, h, tocolor(0, 168, 255, 200))
                        dxDrawText(guiProgressBarGetProgress(element).."%", x-2, y, width+x-2, h+y, tocolor(255, 255, 255), 1, Roboto, "right", "center")
                    elseif element.type == "gui-gridlist" then
                        dxDrawRectangle(x, y, w, h, tocolor(sr, sg, sb, 230/alpha))
                        --dxDrawRectangle(x, y, w, 25, tocolor(35, 35, 35, 250))
                        --> Render columns
                        local columns, rows = guiGridListGetColumnCount(element), guiGridListGetRowCount(element)
                        local paddingX, totalLineWidth = 5, 0
                        for i=1, columns do
                            local title = guiGridListGetColumnTitle(element, i) or ""
                            local width = guiGridListGetColumnWidth(element, i, false)
                            local addLineWidth = width
                            dxDrawText(title, x+7+paddingX, y, x, y+25, primaryColor, 1, RobotoXS, "left", "center")
                            
                            if (totalLineWidth+addLineWidth) >= w then
                                remainingWidth = w - totalLineWidth
                                addLineWidth = remainingWidth
                            end
                            dxDrawLine(x-5+paddingX, y+23, x-5+paddingX+addLineWidth, y+23, tocolor(255, 255, 255, 100))

                            totalLineWidth = totalLineWidth + width
                            paddingX = paddingX + width
                        end
                        local paddingY = 0
                        for i=0, rows-1 do
                            local paddingX = 5
                            for c=1, columns do
                                title = guiGridListGetItemText(element, i, c)
                                width = guiGridListGetColumnWidth(element, c, false)
                                --dxDrawRectangle(x, y+27+paddingY, w, 14, tocolor(35, 35, 35, 200))
                                dxDrawText(title, x+paddingX+7, y+28+paddingY, w+x+paddingX, 12+(y+28+paddingY), primaryColor, 1, RobotoXS, "left", "center")
                                paddingX = paddingX + width
                            end
                            
                            paddingY = paddingY + 14
                        end
                    end
                end
            end
        end
        
        dxSetRenderTarget()
    end;

    render = function(self)
        if not isElement(self.window) then
            self:remove()
            return
        end
        self:prepare()
        dxDrawImage(self.position.x, self.position.y, self.position.w, self.position.h, self.renderTarget)
    end;

    remove = function(self)
        removeBlur(self.blurId)
        for i=1, #ConvertCache do
            local row = ConvertCache[i]
            if row == self then
                table.remove(ConvertCache, i)
            end
        end
        collectgarbage()
    end;
})

addEvent("libs.convert", true)
addEventHandler("libs.convert", root,
    function(args)
        ConvertCache[#ConvertCache + 1] = UI(args);
    end
)

destroy = function()
    buttons = {}
    for i=1, #ConvertCache do
        local row = ConvertCache[i]
        if row then
            row.remove(row)
        end
    end
end
addEventHandler("onClientResourceStop", resourceRoot, destroy)