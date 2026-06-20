--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 猛进的剑角兽  (ID: 79870141)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dinosaur
-- Level 4
-- ATK 1400 | DEF 1200
--
-- Effect Text:
-- 攻击守备表示的怪兽时，这张卡的攻击力超过守备表示怪兽的守备力，对方受到这个超过的数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--猛進する剣角獣
function c79870141.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
end
