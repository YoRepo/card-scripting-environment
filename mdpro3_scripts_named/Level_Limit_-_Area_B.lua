--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Level Limit - Area B  (ID: 3136426)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Change all face-up Level 4 or higher monsters to Defense Position.
--[[ __CARD_HEADER_END__ ]]

--レベル制限B地区
function c3136426.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Pos Change
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SET_POSITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c3136426.target)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetValue(POS_FACEUP_DEFENSE)
	c:RegisterEffect(e2)
end
function c3136426.target(e,c)
	return c:IsLevelAbove(4) and c:IsFaceup()
end
