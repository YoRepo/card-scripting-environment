--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Poisonous Winds  (ID: 95561280)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- WIND monsters cannot be Special Summoned.
-- All face-up WIND monsters on the field lose 500 ATK.
--[[ __CARD_HEADER_END__ ]]

--猛毒の風
function c95561280.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk down
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c95561280.tg)
	e2:SetValue(-500)
	c:RegisterEffect(e2)
	--disable spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,1)
	e3:SetTarget(c95561280.tg)
	c:RegisterEffect(e3)
end
function c95561280.tg(e,c)
	return c:IsAttribute(ATTRIBUTE_WIND)
end
