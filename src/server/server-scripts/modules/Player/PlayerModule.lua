local ReplicatedStorage = game:GetService("ReplicatedStorage")

local DataModule = require(script.Parent.DataModule)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local ServerComm = require(ReplicatedStorage.Packages.Comm).ServerComm

local PlayerService = game:GetService("Players")

local players = {}

function players:_PlayerAdded(player: Player)
    self.playerCache[player] = {data = DataModule:PlayerAdding(player), playerReady = false}
end
function players:_PlayerRemoving(player)
    DataModule:PlayerRemoving(player)
    self.playerCache[player] = nil
end

function players:UpdateData(player: Player, func)
    local playerCache = self.playerCache[player]
    if playerCache then
        func(playerCache, DataModule)
        self.playerCache[player] = playerCache
    end
end

function players:GetData(player: Player)
    local playerCache = self.playerCache[player]
    if playerCache then
        return playerCache
    end
end

return (function() 
    local playerClass = setmetatable({playerCache = {}, {__index = players}})
    PlayerService.PlayerAdded:Connect(function(player)
        playerClass:_PlayerAdded(player)
    end)
    PlayerService.PlayerRemoving:Connect(function(player)
        playerClass:_PlayerRemoving(player)
    end)

    
    local playerComm = ServerComm.new(ReplicatedStorage.Shared.ClientComms, "OnPlayerReadyGetData")
    playerComm:BindFunction("OnPlayerReadyGetData", function(player: Player)
        return playerClass.playerCache[player]
    end)

    return playerClass
end)()