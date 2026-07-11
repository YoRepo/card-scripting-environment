--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Respect Play  (ID: 8951260)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- During their respective turns, each player must show their opponent their hand.
--[[ __CARD_HEADER_END__ ]]

--正々堂々
function c8951260.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_PUBLIC)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_HAND,0)
	e2:SetCondition(c8951260.con1)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_PUBLIC)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(0,LOCATION_HAND)
	e3:SetCondition(c8951260.con2)
	c:RegisterEffect(e3)
end
function c8951260.con1(e)
	return Duel.GetTurnPlayer()==e:GetHandlerPlayer()
end
function c8951260.con2(e)
	return Duel.GetTurnPlayer()~=e:GetHandlerPlayer()
end
