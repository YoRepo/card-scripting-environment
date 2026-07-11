--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Wetlands  (ID: 2084239)
-- Type: Spell / Field
-- Scope: OCG / TCG
--
-- Effect Text:
-- All Aqua-Type/WATER/Level 2 or lower monsters gain 1200 ATK.
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
