

addEventHandler("onResourceStart", resourceRoot,
    function()
        fetchRemote("https://raw.githubusercontent.com/yourpalenes/mta-dxlib/master/meta.xml",
            function(data, err)
                
            end
        )
    end
)