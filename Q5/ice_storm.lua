local AREA_CIRCLECUSTOMS = {
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 1, 0, 0, 0, 0, 0},
        {1, 0, 0, 2, 0, 0, 1},
        {0, 1, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 0, 0, 0},
        {0, 0, 0, 1, 0, 0, 0}
    },
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 1, 0},
        {0, 0, 0, 2, 0, 0, 0},
        {0, 0, 0, 1, 0, 1, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
    },
    {
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 2, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
    },
    {
        {0, 0, 0, 1, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 1, 0, 0, 0},
        {0, 0, 0, 2, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0},
    }
}

local combats = {}
-- setArea can only be called when the script is initialized so we have no choice but to make 4 separate combat classes.
for i=1, #AREA_CIRCLECUSTOMS do
    local cb = Combat()
    cb:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
    cb:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
    cb:setArea(createCombatArea(AREA_CIRCLECUSTOMS[i]))
    function onGetFormulaValues(player, level, magicLevel)
        local min = (level / 5) + (magicLevel * 5.5) + 25
        local max = (level / 5) + (magicLevel * 11) + 50
        return -min, -max
    end
    cb:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
    combats[i] = cb;
end



function executeSequence(creature, variant, iteration)
    -- Each of the 4 combat effect happens 3 times.
    if iteration >= 12 then
        return
    end
    local combat = combats[iteration%4 + 1]
    combat:execute(creature, variant)
    addEvent(function()executeSequence(creature, variant, iteration + 1)end, 300)
end

function onCastSpell(creature, variant)
	executeSequence(creature, variant, 0)
    return true
end
