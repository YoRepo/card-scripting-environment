--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 隼骑士  (ID: 21015833)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 3
-- ATK 1000 | DEF 700
--
-- Effect Text:
-- ①：这张卡在同1次的战斗阶段中可以作2次攻击。
--[[ __CARD_HEADER_END__ ]]

--隼の騎士
function c21015833.initial_effect(c)
	--double attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
