--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 枪兵龙人  (ID: 11125718)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Dragon
-- Level 4
-- ATK 1500 | DEF 1800
--
-- Effect Text:
-- ①：这张卡向守备表示怪兽攻击的场合，给与攻击力超过那个守备力的数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--ランサー・ドラゴニュート
function c11125718.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
end
