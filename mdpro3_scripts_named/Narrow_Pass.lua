--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Narrow Pass  (ID: 40172183)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can only be activated when both players have 2 monsters or less on their respective sides
-- of the field.
-- Both players can only Normal Summon up to 2 additional monsters on their sides of the field.
--[[ __CARD_HEADER_END__ ]]

--狭き通路
function c40172183.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c40172183.condition)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_CANNOT_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,1)
	e2:SetTarget(c40172183.sumlimit)
	c:RegisterEffect(e2)
end
function c40172183.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)<=2
		and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)<=2
end
function c40172183.sumlimit(e,c,sp,st)
	return Duel.GetFieldGroupCount(sp,LOCATION_MZONE,0)>=2
end
