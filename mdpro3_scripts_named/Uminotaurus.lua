--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 海牛头人  (ID: 30464153)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 4
-- ATK 1700 | DEF 1000
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，自己场上的鱼族·海龙族·水族怪兽向守备表示怪兽攻击时，若攻击力超过那个守备力，给与对方基本分那个数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--ウミノタウルス
function c30464153.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c30464153.target)
	c:RegisterEffect(e1)
end
function c30464153.target(e,c)
	return c:IsRace(RACE_FISH+RACE_SEASERPENT+RACE_AQUA)
end
