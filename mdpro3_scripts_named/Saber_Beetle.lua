--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 剑角甲虫  (ID: 49645921)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level 6
-- ATK 2400 | DEF 600
-- Setcode: 13
--
-- Effect Text:
-- 这张卡攻击守备表示的怪兽时，若攻击力超过那个守备力，给与对方基本分那个数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--セイバー・ビートル
function c49645921.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
end
