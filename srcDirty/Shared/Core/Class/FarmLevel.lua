local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Packages = ReplicatedStorage:WaitForChild("Packages")

local TableUtil = require(Packages.TableUtil)

local Library = require(Shared.Library)
local ObjectData = Library.ObjectData
local farmLevelData = ObjectData.FarmLevel

--[[
    Parameters:
    level: number, Default: Current level.
    Returns:
    level: number
]]
local FarmLevel = {}
function FarmLevel:SetLevel(level)
    if farmLevelData[tostring(level)] then
        self.farmLevelData = TableUtil.Copy(farmLevelData[tostring(level)], true)
    end
end
--[[
    Parameters:
    level: number, default: Current level.
    Returns:
    level: number
]]
function FarmLevel:GetLevel(level): number
    if not level then
        return self.farmLevelData.Level
    end
end
--[[
    Parameters:
    level: number, default: Current level.
    Returns:
    array: requirements
]]
function FarmLevel:GetRequirements(level)
    if not level then
        return self.farmLevelData.Requirements
    end
end
--[[
    Parameters:
    level: number, default: Current level.
    Returns:
    level: number
]]
function FarmLevel:GetCashPerLitre(level)
    if not level then
        return self.farmLevelData.CashPerLitre
    end
end
--[[
    Parameters:
    level: number, default: Current level.
    Returns:
    array: {info: string, name: string}
]]
function FarmLevel:GetLevelInfo(level)
    if not level then
        return self.farmLevelData.Info
    end
end


local function new(playerData)
    local farmLevel = setmetatable({
    }, {__index = FarmLevel})
    farmLevel:SetLevel(playerData.CurrentFarmLevel.Level)
    return farmLevel
end

return setmetatable({new = new}, {})