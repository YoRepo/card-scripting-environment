--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Witch's Apprentice  (ID: 80741828)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 2
-- ATK 550 | DEF 500
-- Scope: OCG / TCG
--
-- Effect Text:
-- As long as this card remains face-up on the field, increase the ATK of all DARK monsters by 500
-- points and decrease the ATK of all LIGHT monsters by 400 points.
--[[ __CARD_HEADER_END__ ]]

--見習い魔女
function c80741828.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTarget(c80741828.tg1)
	e1:SetValue(500)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetTarget(c80741828.tg2)
	e2:SetValue(-400)
	c:RegisterEffect(e2)
end
function c80741828.tg1(e,c)
	return c:IsAttribute(ATTRIBUTE_DARK)
end
function c80741828.tg2(e,c)
	return c:IsAttribute(ATTRIBUTE_LIGHT)
end
