--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 暗黑三角怪鸟龙  (ID: 65287621)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dinosaur
-- Level 6
-- ATK 2400 | DEF 1500
--
-- Effect Text:
-- 这张卡攻击守备表示的怪兽时，攻击力超出部分对对方造成战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--暗黒ドリケラトプス
function c65287621.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
end
