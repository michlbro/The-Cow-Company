local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Shared = ReplicatedStorage:WaitForChild("Shared")

local Core = require(Shared.Core)
local ServerCore = require(ServerStorage.Core)

local PlayerClass = Core.PlayerClass
local DataService = ServerCore.DataService

local PlayerService = game:GetService("Players")
PlayerService.PlayerAdded:Connect(function(playerAdded: Player)
    local player = PlayerClass.new()
end)

