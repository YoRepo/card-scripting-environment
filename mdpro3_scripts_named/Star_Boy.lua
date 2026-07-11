--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Star Boy  (ID: 8201910)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level: 2
-- ATK 550 | DEF 500
-- Scope: OCG / TCG
--
-- Effect Text:
-- As long as this card remains face-up on the field, increase the ATK of all WATER monsters by 500
-- points and decrease the ATK of all FIRE monsters by 400 points.
--[[ __CARD_HEADER_END__ ]]

--スター・ボーイ
function c8201910.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTarget(c8201910.tg1)
	e1:SetValue(500)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetTarget(c8201910.tg2)
	e2:SetValue(-400)
	c:RegisterEffect(e2)
end
function c8201910.tg1(e,c)
	return c:IsAttribute(ATTRIBUTE_WATER)
end
function c8201910.tg2(e,c)
	return c:IsAttribute(ATTRIBUTE_FIRE)
end
