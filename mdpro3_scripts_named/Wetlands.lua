--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 湿地草原  (ID: 2084239)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 全部的水族·水属性·2星以下怪兽的攻击力上升1200。
--[[ __CARD_HEADER_END__ ]]

--湿地草原
function c2084239.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c2084239.tg)
	e2:SetValue(1200)
	c:RegisterEffect(e2)
end
function c2084239.tg(e,c)
	return c:IsLevelBelow(2) and c:IsAttribute(ATTRIBUTE_WATER) and c:IsRace(RACE_AQUA)
end
