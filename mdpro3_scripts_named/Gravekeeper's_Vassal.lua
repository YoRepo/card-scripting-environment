--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 守墓的从者  (ID: 99690140)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 3
-- ATK 700 | DEF 500
-- Setcode: 46
--
-- Effect Text:
-- 这张卡给与对方造成的战斗伤害，算作这张卡的效果造成的伤害使用。
--[[ __CARD_HEADER_END__ ]]

--墓守の従者
function c99690140.initial_effect(c)
	--battle damage to effect damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_BATTLE_DAMAGE_TO_EFFECT)
	c:RegisterEffect(e1)
end
