--[[
Q3 - Fix or improve the name and the implementation of the below method

function do_sth_with_PlayerParty(playerId, membername)
    player = Player(playerId)
    local party = player:getParty()

    for k,v in pairs(party:getMembers()) do
        if v == Player(membername) then
            party:removeMember(Player(membername))
        end
    end
end
]]

--[[
    Since the content of the function is clearly to remove player from their party. We should name it as so.
    Additionally, checking if the player exists in the party is a check that should be done inside the removeMember function instead of the current function. 
    To compensate, the function should make sure the player is actually in a party.
]]

function removePlayerFromParty(playerId, membername)
    player = Player(playerId)
    local party = player:getParty()

    if party ~= nil then
        party:removeMember(Player(membername))
    end
end