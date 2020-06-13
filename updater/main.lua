local openVersionFile = {}

addEventHandler("onResourceStart", resourceRoot,
    function()
        local openVersionFile = fileOpen("updater/version.cfg")
        currentVersionData = fromJSON(fileRead(openVersionFile, fileGetSize(openVersionFile)))
        currentVersion = currentVersionData.version
        fileClose(openVersionFile)

        fetchRemote("https://raw.githubusercontent.com/yourpalenes/mta-dxlib/master/updater/version.cfg",
            function(data, error)
                if error == 0 then
                    local versionData = fromJSON(data) or false
                    if versionData then
                        local newestVersion = versionData.version
                        if newestVersion > currentVersion then
                            print("mta-dxlib > script version is outdated, there is an update")
                            print("mta-dxlib > current version: "..currentVersion.." - newest version: "..newestVersion)
                            print("mta-dxlib > current version last update: "..currentVersionData.last_update)
                            print(" ")
                            print("mta-dxlib > type \"update mta-dxlib\" to update")
                        end
                    end
                end
            end
        )
    end
)

addCommandHandler("update",
    function(element, cmd, var)
        if element.type == "console" then
            if var == "mta-dxlib" then
                print("mta-dxlib > starting download process...")
                print("mta-dxlib > you can find old files in \"old/\" folder")

                local meta = xmlLoadFile("meta.xml")
                local metaData = xmlNodeGetChildren(meta)
                if metaData then
                    for index, node in ipairs(metaData) do
                        local fileType = xmlNodeGetName(node)
                        local fileLocation = xmlNodeGetAttribute(node, "src")
                        if fileType == "script" or fileType == "file" then
         
                            if fileExists("old/"..currentVersion.."/"..fileLocation) then
                                fileDelete("old/"..currentVersion.."/"..fileLocation)
                            end
                            fileCopy(fileLocation, "old/"..currentVersion.."/"..fileLocation)
                        end
                    end
                end
                xmlUnloadFile(meta)
            elseif var == "cegui" then

            elseif var == "cef" then

            end
        end
    end
)