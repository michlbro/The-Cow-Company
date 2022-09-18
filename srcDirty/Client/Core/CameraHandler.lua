local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage:WaitForChild("Shared") -- Expose some functions to the server

local Library = require(Shared.Library)

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local cameraHandler = {}

--[[
    TODO: 
    Finish of zooming for camera.
]]
function cameraHandler:Init()
    if self.Runtime then
        self.Runtime:Disconnect()
    end

    local camera = workspace.CurrentCamera
    local cameraCFrame = camera.CFrame
    local cameraOrigin = Library.CameraConfig.CameraOrigin
    local cameraTargetAngle = CFrame.fromEulerAnglesYXZ(math.rad(-45), math.rad(45), 0) -- Diagonal down.

    local bounderies = Library.FarmConfig.LandBounderies
    local zoomSize = Library.CameraConfig.ZoomSize
    local tweenInfo = Library.CameraConfig.TweenInfoMove

    local currentUserInputLocation = Vector2.new()
    local originUserInputLocation = Vector2.new()
    local dragging = false
    local touched = false

    UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
        if gameProcessedEvent then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            currentUserInputLocation = UserInputService:GetMouseLocation()
            originUserInputLocation = UserInputService:GetMouseLocation()
            cameraCFrame = camera.CFrame
            touched = false
            dragging = true
        end
    end)
    UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
        if gameProcessedEvent then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)


    self.Runtime = RunService.RenderStepped:Connect(function()
        if dragging then
            if not touched then
                currentUserInputLocation = UserInputService:GetMouseLocation()
            end
            local deltaMouse = currentUserInputLocation - originUserInputLocation
            local xPos = deltaMouse.X - deltaMouse.Y
            local yPos = deltaMouse.Y - deltaMouse.X
            local cframeTarget = CFrame.new(cameraCFrame.Position) * CFrame.new(xPos, cameraOrigin.Y, yPos) * cameraTargetAngle
            TweenService:Create(camera, tweenInfo, {CFrame = cframeTarget}):Play()
        else
            cameraCFrame = camera.CFrame
            local xPos = math.clamp(cameraCFrame.Position.X, -bounderies.X, bounderies.X)
            local yPos = math.clamp(cameraCFrame.Position.Y, -bounderies.Y, bounderies.Y)
            local cframeTarget = CFrame.new(xPos, cameraCFrame.Position.Y, yPos) * cameraTargetAngle
            if cframeTarget == cameraCFrame then
                return
            end
            TweenService:Create(camera, tweenInfo, {CFrame = cframeTarget}):Play()
        end
    end)
end

return setmetatable({

}, {__index = cameraHandler})