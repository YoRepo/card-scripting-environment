--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 激昂的牛头人  (ID: 76909279)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level 4
-- ATK 1700 | DEF 1000
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，自己的兽族·兽战士族·鸟兽族怪兽向守备表示怪兽攻击的场合，给与对方为攻击力超过那个守备力的数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--激昂のミノタウルス
function c76909279.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c76909279.target)
	c:RegisterEffect(e1)
end
function c76909279.target(e,c)
	return c:IsRace(RACE_BEASTWARRIOR+RACE_WINDBEAST+RACE_BEAST)
end
