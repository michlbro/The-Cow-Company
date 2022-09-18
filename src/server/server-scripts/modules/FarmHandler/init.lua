local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")

local Comm = require(ReplicatedStorage.Packages.Comm)
local ServerComm = Comm.ServerComm

local FarmHandler = {}

local GameUpgrades = require(Shared.GameUpgrades)
function FarmHandler:NewPlayer(playerData)
    local PlayerLevel = GameUpgrades.Level["1"]
    local data = playerData.data

    data.CowFarmLevel = 1
    data.LifeTime.CowFarmLevel = 1;

    

function FarmHandler:SetupPlayerData(player)
    local NewPlayer = false
    self.players:UpdateData(player, function(playerData, dataModule)
        playerData.playerReady = true
        if playerData.data.LifeTime.NewPlayer then
            NewPlayer = true
        end
        playerData.data.LifeTime.NewPlayer = false
        dataModule:UpdatePlayerData(player, playerData.data, true)
    end)
    local playerData = self.players:GetData(player)
    if NewPlayer then
        self:NewPlayer(playerData)
    end

end

return (function(Players)
    local FarmHandlerClass = setmetatable({
        players = Players
    }, {__index = FarmHandler})

    local playerReadyComm = ServerComm.new(Shared.ClientComms, "PlayerReadyComm")
    playerReadyComm:BindFunction("OnPlayerReady", function(player: Player)
        FarmHandlerClass:SetupPlayerData(player)
    end)
end)()