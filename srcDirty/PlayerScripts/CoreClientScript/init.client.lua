local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerService = game:GetService("Players")
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Client = PlayerService.LocalPlayer:WaitForChild("PlayerScripts")

local Core = require(Shared.Core)
local ClientCore = require(Client.Core)

local CameraHandler = ClientCore.CameraHandler
CameraHandler:Init()