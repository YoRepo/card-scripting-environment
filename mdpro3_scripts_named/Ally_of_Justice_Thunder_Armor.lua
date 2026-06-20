--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 正义盟军 雷铠兵  (ID: 71438011)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 8
-- ATK 2700 | DEF 2200
-- Setcode: 1
--
-- Effect Text:
-- 这张卡不能特殊召唤。只要这张卡在自己场上表侧表示存在，自己场上存在的名字带有「正义盟军」的怪兽攻击守备表示怪兽时，若攻击力超过那个守备力，给与对方基本分那个数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--A・O・J サンダー・アーマー
function c71438011.initial_effect(c)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_PIERCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x1))
	c:RegisterEffect(e2)
end
