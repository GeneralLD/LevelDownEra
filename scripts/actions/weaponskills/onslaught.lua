-----------------------------------
-- Onslaught
-- Axe weapon skill
-- Skill Level: N/A
-- Lowers target's params.accuracy. Additional effect: temporarily increases Attack.
-- Available only when equipped with the Relic Weapons Ogre Killer (Dynamis use only) or Guttler or Cleofun Axe (with Latent active).
-- These Relic Weapons are only available to Beastmasters, so only they can use this Weapon Skill.
-- One hit attack despite of non single-hit animation
-- The attack increase seems to be 10%.
-- Aligned with the Shadow Gorget & Soil Gorget.
-- Aligned with the Shadow Belt & Soil Belt.
-- Element: None
-- Modifiers: DEX:80%
-- 100%TP    200%TP    300%TP
-- 2.75      2.75      2.75
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 2.75, 2.75, 2.75 }
    params.dex_wsc = 0.6

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.dex_wsc = 0.8
    end

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.RELIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.ACCURACY_DOWN
    local actionElement = xi.element.EARTH
    local power         = 30
    local duration      = math.floor(120 * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
