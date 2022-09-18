local ReplicatedStorage = game:GetService("ReplicatedStorage")

local modules = script.Parent.modules
local shared = ReplicatedStorage:WaitForChild("Shared")

local Players = require(modules.Player.PlayerModule)
local Farm = require(modules.FarmHandler)

Farm:Init(Players)