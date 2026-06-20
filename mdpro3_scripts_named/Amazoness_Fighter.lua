--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 亚马逊格斗战士  (ID: 55821894)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1500 | DEF 1300
-- Setcode: 4
--
-- Effect Text:
-- 这张卡进行战斗时，这张卡的控制者所受的战斗伤害为零。
--[[ __CARD_HEADER_END__ ]]

--アマゾネスの格闘戦士
function c55821894.initial_effect(c)
	--battle dam 0
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
