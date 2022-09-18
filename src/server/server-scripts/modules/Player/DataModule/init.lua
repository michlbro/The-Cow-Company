local dataConfig = require(script.dataConfig)

local DataService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local DataStore = {}

function DataStore:OnPlayerRemoving(player: Player)
    if not self.playerCache[player] then
        warn(string.format("[DATASTORE]: Player, %s does not exist in cache.", player.Name))
        return
    end
    local success, err = pcall(self.playerDataStore.SetAsync, self.playerDataStore, player.UserId, self.playerCache[player])
    self.playerCache[player] = nil
    if not success then
        warn(string.format("[DATASTORE]: %s, %s", player.Name, err))
    end
end

function DataStore:OnPlayerAdding(player: Player)
    local success, playerData = pcall(self.playerDataStore.GetAsync, self.playerDataStore, player.UserId)
    if success then
        self.playerCache[player] = TableUtil.Reconcile(playerData, dataConfig.playerDataStore.Data)
    else
        self.playerCache[player] = TableUtil.Reconcile({}, dataConfig.playerDataStore.Data)
    end
    return self.playerCache[player]
end

function DataStore:UpdatePlayerData(player: Player, data , override: boolean)
    if override then
        if self.playerCache[player] then
            self.playerCache[player] = data
        end
        return
    end
    if self.playerCache[player] then
        self.playerCache[player] = TableUtil.Reconcile(data, dataConfig.playerDataStore.Data)
    end
end

function DataStore:GetPlayerData(player: Player)
    return TableUtil.Reconcile(self.playerCache[player], dataConfig.playerDataStore.Data)
end

--[[
    Maybe to visit another company?? Crazy.
]]
function DataStore:GetAnotherPlayerData(playerUserId: number)
    local success, playerData = pcall(self.playerDataStore.GetAsync, self.playerDataStore, playerUserId)
    if success then
        return TableUtil.Reconcile(playerData, dataConfig.playerDataStore.Data)
    else
        return TableUtil.Reconcile({}, dataConfig.playerDataStore.Data)
    end
end

return (function()
    local success, playerDataStore = pcall(DataService.GetDataStore, DataService, dataConfig.playerDataStore.Name)
    if not success then
        error("[DATASTORE]: Datastore had an error. Not loading any data.")
        return
    end
    return setmetatable({
        playerDataStore = playerDataStore;
        playerCache = {};
    }, {__index = DataStore})
end)()
