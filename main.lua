--[[
Please credit me if you, use this loader as I spent 30 minutes on perfecting it as im trying to make this my best script

      @@@@@@           @@@@@@
      @@@@@@@@@@       @@@@@@@@@@
    @@@@@@@@@@@@@@   @@@@@@@@@@@@@@
  @@@@@@@@@@@@@@@@@ @@@@@@@@@@@@@@@@@
 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      @@@@@@@@@@@@@@@@@@@@@@@@@@@
        @@@@@@@@@@@@@@@@@@@@@@@
          @@@@@@@@@@@@@@@@@@@
            @@@@@@@@@@@@@@@
              @@@@@@@@@@@
                @@@@@@@
                  @@@
]]

local indexScriptText = game:HttpGet("https://github.com/abusingroblox/Inko/blob/main/Games/index.lua?raw=true", true)
local id = loadstring(indexScriptText)()

if not id then
    warn("Inko: Failed to load or execute the index file.")
    return
end
function glc()
    local indexUrl = "https://github.com/abusingroblox/Inko/blob/main/Games/index.lua?raw=true"
    local success, response = pcall(function()
        return game:HttpGet(indexUrl, true)
    end)
    if not success or not response then
        warn("Inko: Error! Could not fetch the game list from GitHub. Please check your connection.")
        return 
    end
    local indexFunc = loadstring(response)
    if not indexFunc then
        warn("Inko: Error! The index file seems to have a syntax error.")
        return
    end
    local indexData = indexFunc()
    local outputString = {"📋 Inko - Supported Games List 📋"}
    for scriptName, placeIdList in pairs(indexData) do
        local idsString = table.concat(placeIdList, ", ")
        table.insert(outputString, string.format("- %s (IDs: %s)", scriptName, idsString))
    end
    local finalClipboardText = table.concat(outputString, "\n")
    setclipboard(finalClipboardText)
end
for scriptName, placeIdList in pairs(id) do
    for _, placeId in ipairs(placeIdList) do
        if game.PlaceId == placeId then
            print("Inko: Match found! Current Place ID:", game.PlaceId, "-> Loading script:", scriptName)
            local gameScriptUrl = "https://raw.githubusercontent.com/abusingroblox/Inko/main/Games/" .. scriptName
            setclipboard(gameScriptUrl)
            loadstring(game:HttpGet(gameScriptUrl, true))()
            return
        end
    end
end
glc()
game.Players.LocalPlayer:Kick("Inko: This game may not be supported. The game list has been copied to your clipboard, if you suspect this is a bug please report it to our team: discord.gg/HwHHvdh5Ef")
