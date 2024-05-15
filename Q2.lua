--[[
Q2 - Fix or improve the implementation of the below method

function printSmallGuildNames(memberCount)
-- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
    local guildName = result.getString("name")
    print(guildName)
end
]]

--[[
    2 things can be fixed:
    1) Handling the case where guildName did not yield a result
    2) The program does not print all guilds. We have to go through each guild name and print it out.
]]

function printSmallGuildNames(memberCount)
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
    if resultId ~= false then
        repeat
            local guildName = result.getString("name")
            print(guildName)
        until not result.next(resultId)
        result.free(resultId)
    end
    return true
end