local RunService = game:GetService("RunService")
local camera = {}

--[[
    allows to wrap a render stepped signal on a function, returns a function to disconnect and stop it from running + OnEnd function to be fired when ended (optional)
]]
local function OnRuntime(Func, OnEnd)
    local connection
    connection = RunService.RenderStepped:Connect(Func)
    return function()
        connection:Disconnect()
        if OnEnd then
            OnEnd()
        end
    end
end

function camera:Main()
    if self.OnRuntime then
        self.OnRuntime()
    end

    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")

    local currentCamera = workspace.CurrentCamera
    local defaultCameraLocation = CFrame.new(0, 100, 0)
    local cameraLocation = Vector3.new()
    local angle = math.rad(45)

    -- MOUSE/SCREEN DRAG
    local dragBool = false
    local deltaMouse = Vector2.new()
    local currentMouseOrigin = Vector2.new()
    local mouseBehaviour = false
    local sensitivity = 0.05
    local tweenInfo = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local bounderies = Vector3.new(100, 0, 100)

    --MOUSE/SCREEN ZOOM
    local zoomScale = 1
    local zoomSize = 30
    --[[UserInputService.TouchPinch:Connect(function(touchPositions, totalTranslation, velocity, state, gameProcessedEvent)
        -- TODO: This later on a device since it does not work on device emulator
    end)]]
    UserInputService.TouchMoved:Connect(function(inputObject, gameProcessedEvent)
        if gameProcessedEvent then return end
        dragBool = true
        local currentMouseLocation = Vector2.new(inputObject.Position.X, inputObject.Position.Y)
        deltaMouse = (currentMouseLocation - currentMouseOrigin)
    end)
    UserInputService.TouchStarted:Connect(function(inputObject, gameProcessedEvent)
        if gameProcessedEvent then return end
        cameraLocation = currentCamera.CFrame.Position
        currentMouseOrigin = Vector2.new(inputObject.Position.X, inputObject.Position.Y)
    end)
    UserInputService.TouchEnded:Connect(function()
        dragBool = false
        deltaMouse = Vector2.zero
    end)
    UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
        if gameProcessedEvent then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            cameraLocation = currentCamera.CFrame.Position
            currentMouseOrigin = UserInputService:GetMouseLocation()
            mouseBehaviour = true
            dragBool = true
        end
    end)
    UserInputService.InputChanged:Connect(function(input, gameProcessedEvent)
        if gameProcessedEvent then return end
        if input.UserInputType == Enum.UserInputType.MouseWheel then
            local target = zoomScale + 0.1 * input.Position.Z
            zoomScale = (target > 1) and 1 or (target < 0) and 0 or target
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            mouseBehaviour = false
            dragBool = false
            deltaMouse = Vector2.zero
        end
    end)

    self.OnRuntime = OnRuntime(function()
        if currentCamera.CameraType ~= Enum.CameraType.Scriptable then
            currentCamera.CameraType = Enum.CameraType.Scriptable
            currentCamera.CFrame = defaultCameraLocation
        end
        if dragBool then
            if mouseBehaviour then
                local currentMouseLocation = UserInputService:GetMouseLocation()
                deltaMouse = (currentMouseLocation - currentMouseOrigin)
            end
            local cframeTarget = CFrame.new(cameraLocation.X, defaultCameraLocation.Y + math.clamp(zoomScale * zoomSize, 0, zoomSize), cameraLocation.Z) * CFrame.new(Vector3.new(-deltaMouse.X - deltaMouse.Y, 0, deltaMouse.X - deltaMouse.Y) * sensitivity) * CFrame.fromEulerAnglesYXZ(-angle, angle, 0)
            TweenService:Create(currentCamera, tweenInfo, {CFrame = cframeTarget}):Play()
        else
            local currentCameraPosition = currentCamera.CFrame.Position
            local xTarget = math.clamp(currentCameraPosition.X, -bounderies.X, bounderies.X)
            local zTarget = math.clamp(currentCameraPosition.Z, -bounderies.Z, bounderies.Z)
            local cframeTarget = CFrame.new(xTarget, defaultCameraLocation.Y + math.clamp(zoomScale * zoomSize, 0, zoomSize), zTarget) * CFrame.fromEulerAnglesYXZ(-angle, angle, 0)
            TweenService:Create(currentCamera, tweenInfo, {CFrame = cframeTarget}):Play()
        end
    end, function()
        self.OnRuntime = nil
    end)
end

return (function()
    return setmetatable({

    }, {__index = camera})
end)()