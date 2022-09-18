--[[
    On player join, lets load up camera module and return it to be used by other modules.
]]
local modules = script.Parent:WaitForChild("modules")

local cameraModule = require(modules.CameraModule)
cameraModule:Main()