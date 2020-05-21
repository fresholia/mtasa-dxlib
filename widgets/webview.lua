Webview = setmetatable({
        constructor = function(self)
            self.renderData = false
            self.requestData = {}
            self.ready = false
            self.scroll = 0
            self.lastClick = 0
            return self
        end;
        create = function(self, x, y, w, h, url)
            self.browser = createBrowser(w, h, true, true)
            self.position = Vector2(x, y)
            self.size = Vector2(w, h)

            addEventHandler("onClientBrowserCreated", self.browser,
                function()
                    loadBrowserURL(self.browser, url)
                    setDevelopmentMode(true, true)
                end
            )
            addEventHandler("viewerDomLoaded", root,
                function()
                    self.ready = true
                    for index, code in ipairs(self.requestData) do
                        self.browser:executeJavascript(code)
                    end
                    self.requestData = {}
                end
            )
            self.render = function(self)
                if not isTimer(self.renderData) then
                    self.renderData = setTimer(
                        function()
                            dxDrawImage(self.position.x, self.position.y, self.size.x, self.size.y, self.browser)
                            focusBrowser(self.browser)
                            if getKeyState("mouse1") and self.lastClick+200 <= getTickCount() then
                                self.lastClick = getTickCount()
                                injectBrowserMouseDown(self.browser, "left")
                                injectBrowserMouseUp(self.browser, "left")
                            end
                            if isCursorShowing() then
                                local x, y, _, _, _ = getCursorPosition()
                                injectBrowserMouseMove(self.browser, x*screenSize.x, y*screenSize.y)
                            end
                        end,
                    0, 0)
                end
                return self
            end;
            return self
        end;
        push = function(self, code)
            if not self.ready then
                table.insert(self.requestData, code)
            else
                self.browser:executeJavascript(code)
            end
        end;
        remove = function(self)
            if isTimer(self.renderData) then
                killTimer(self.renderData)
            end
            self.browser:destroy()
            self = nil
            collectgarbage()
            return true
        end;
    }, {
    __call = function(cls, ...)
        local self = {}
        setmetatable(self, {
            __index = cls
        })

        self:constructor(...)

        return self
    end
})

addEvent("viewerDomLoaded", true)
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        LocalDocument = Webview():create(0, 0, screenSize.x, screenSize.y, "http://mta/local/assets/html/index.html"):render()
        showCursor(true)
    end
)