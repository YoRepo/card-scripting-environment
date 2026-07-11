--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Level Limit - Area A  (ID: 54976796)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Change all face-up Level 3 or lower monsters to Attack Position.
--[[ __CARD_HEADER_END__ ]]

--レベル制限A地区
function c54976796.initial_effect(c)
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
	e2:SetTarget(c54976796.target)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetValue(POS_FACEUP_ATTACK)
	c:RegisterEffect(e2)
end
function c54976796.target(e,c)
	return c:IsLevelBelow(3) and c:IsFaceup()
end
