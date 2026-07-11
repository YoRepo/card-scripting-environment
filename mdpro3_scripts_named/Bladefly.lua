--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Bladefly  (ID: 28470714)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Insect
-- Level: 2
-- ATK 600 | DEF 700
-- Scope: OCG / TCG
--
-- Effect Text:
-- As long as this card remains face-up on the field, increase the ATK of all WIND monsters by 500
-- points and decrease the ATK of all EARTH monsters by 400 points.
--[[ __CARD_HEADER_END__ ]]

--ブレードフライ
function c28470714.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTarget(c28470714.tg1)
	e1:SetValue(500)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetTarget(c28470714.tg2)
	e2:SetValue(-400)
	c:RegisterEffect(e2)
end
function c28470714.tg1(e,c)
	return c:IsAttribute(ATTRIBUTE_WIND)
end
function c28470714.tg2(e,c)
	return c:IsAttribute(ATTRIBUTE_EARTH)
end
