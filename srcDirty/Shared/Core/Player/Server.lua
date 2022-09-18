local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Packages = ReplicatedStorage:WaitForChild("Packages")

local ServerComm = require(Packages.Comm).ServerComm
local getPlayer = ServerComm.new(Shared.Comms, "OnPlayerReady")

local playerCache = {}
getPlayer:BindFunction("GetData", function(player: Player)
    local playerClass = playerCache[player]
    while not playerClass do
        task.wait(1)
        playerClass = playerCache[player]
    end
    return playerClass:GetSerealisedData()
end)

local playerMethods = {}
function playerMethods:GetSerealisedData()
    local playerData = self.data
    return playerData
end

local player = {}
local function new(player: Player, playerData)
    local playerClass = setmetatable({
        data = playerData;
        ready = false;
    }, {__index = playerMethods})
    playerCache[player] = playerClass

    return playerClass
end

return setmetatable({new = new}, {})