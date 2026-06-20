--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 守墓的长枪兵  (ID: 63695531)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 4
-- ATK 1500 | DEF 1000
-- Setcode: 46
--
-- Effect Text:
-- 这张卡攻击守备表示的怪兽时，若这张卡的攻击力高于守备怪兽的守备力，则超过部分的数值对对方造成战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--墓守の長槍兵
function c63695531.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
end
