

addEventHandler("onResourceStart", resourceRoot,
    function()
        fetchRemote("https://raw.githubusercontent.com/yourpalenes/mta-dxlib/master/updater/version.cfg",
            function(data, error)
                if error == 0 then
                    local versionData = tostring(data) and fromJSON(tostring(data)) or false
                    if versionData then
                        
                    end
                end
            end
        )
    end
)