--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 元素英雄 金刃侠  (ID: 59793705)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 7
-- ATK 2600 | DEF 1800
-- Setcode: 12296
--
-- Effect Text:
-- ①：这张卡向守备表示怪兽攻击的场合，给与对方为攻击力超过那个守备力的数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--E・HERO エッジマン
function c59793705.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
end
