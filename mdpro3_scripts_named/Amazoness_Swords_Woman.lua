--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 亚马逊剑士  (ID: 94004268)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1500 | DEF 1600
-- Setcode: 4
--
-- Effect Text:
-- ①：这张卡的战斗发生的对自己的战斗伤害由对方代受。
--[[ __CARD_HEADER_END__ ]]

--アマゾネスの剣士
function c94004268.initial_effect(c)
	--reflect battle dam
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
