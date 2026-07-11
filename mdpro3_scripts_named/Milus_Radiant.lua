--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Milus Radiant  (ID: 7489323)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level: 1
-- ATK 300 | DEF 250
-- Scope: OCG / TCG
--
-- Effect Text:
-- As long as this card remains face-up on the field, increase the ATK of all EARTH monsters by 500
-- points and decrease the ATK of all WIND monsters by 400 points.
--[[ __CARD_HEADER_END__ ]]

--ミリス・レディエント
function c7489323.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTarget(c7489323.tg1)
	e1:SetValue(500)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetTarget(c7489323.tg2)
	e2:SetValue(-400)
	c:RegisterEffect(e2)
end
function c7489323.tg1(e,c)
	return c:IsAttribute(ATTRIBUTE_EARTH)
end
function c7489323.tg2(e,c)
	return c:IsAttribute(ATTRIBUTE_WIND)
end
