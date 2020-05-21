Webview = setmetatable({
        constructor = function(self)
            self.renderData = false
            return self
        end;
        create = function(self, x, y, w, h, url)
            self.browser = createBrowser(w, h, true, true)
            self.scroll = 0
            self.position = Vector2(x, y)
            self.size = Vector2(w, h)

            addEventHandler("onClientBrowserCreated", self.browser,
                function()
                    loadBrowserURL(self.browser, url)
                    setDevelopmentMode(true, true)
                end
            )
            self.render = function(self)
                if not isTimer(self.renderData) then
                    self.renderData = setTimer(
                        function()
                            dxDrawImage(self.position.x, self.position.y, self.size.x, self.size.y, self.browser)
                        end,
                    0, 0)
                end
                return self
            end;
            return self
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


addEventHandler("onClientResourceStart", resourceRoot,
    function()
        LocalDocument = Webview():create(0, 0, screenSize.x, screenSize.y, "http://mta/local/assets/html/index.html"):render()
        LoadTick = getTickCount()
    end
)

addEvent("viewerDomLoaded", true)
addEventHandler("viewerDomLoaded", root,
    function()
        print("Webview: loaded succesfully "..getTickCount()-LoadTick.."ms")
    end
)