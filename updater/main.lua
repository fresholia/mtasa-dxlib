

addEventHandler("onResourceStart", resourceRoot,
    function()
        local oepnVersionData = fileOpen("updater/version.cfg")
        currentVersionData = fromJSON(fileRead(oepnVersionData, fileGetSize(oepnVersionData)))
        currentVersion = currentVersionData.version
        fileClose(oepnVersionData)

        fetchRemote("https://raw.githubusercontent.com/yourpalenes/mta-dxlib/master/updater/version.cfg",
            function(data, error)
                if error == 0 then
                    local versionData = fromJSON(data) or false
                    if versionData then
                        local newestVersion = versionData.version
                        if newestVersion > currentVersion then
                            outputDebugString("mta-dxlib > script version is outdated, there is an update")
                            outputDebugString("mta-dxlib > curr version: "..currentVersion.." - newest version: "..newestVersion)
                            outputDebugString("mta-dxlib > current version last update: "..currentVersionData.last_update)
                            outputDebugString(" ")
                            outputDebugString("mta-dxlib > type \"update mta-dxlib\" to update")
                        end
                    end
                end
            end
        )
    end
)