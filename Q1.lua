--[[ 
Q1 - Fix or improve the implementation of the below methods

local function releaseStorage(player)
    player:setStorageValue(1000, -1)
end

function onLogout(player)
    if player:getStorageValue(1000) == 1 then
        addEvent(releaseStorage, 1000, player)
    end
    return true
end
]]


-- The function releaseStorage is failing to pass over the index of the storage to the event. The fix is to use the actual parameters

local function releaseStorage(idx, player)
    player:setStorageValue(idx, -1)
end

function onLogout(player)
    if player:getStorageValue(1000) == 1 then
        addEvent(releaseStorage, 1000, player)
    end
    return true
end

