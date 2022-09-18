--[[
    Lazy loading module.
]]

local CoreModules = script

local modules = {}
setmetatable({}, {
    __index = function(_, moduleName)
        if not CoreModules[moduleName] and CoreModules[moduleName]:WhichIsA("ModuleScript") then return end
        local loadedModule = require(CoreModules[moduleName])
        modules[moduleName] = loadedModule
        return loadedModule
    end
})

--return modules
--Manual loading for developing
return {
    FarmLevel = require(script.FarmLevel)
}