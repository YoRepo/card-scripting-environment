--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Tyrant's Tirade  (ID: 76721030)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Tribute 2 monsters.
-- Effects of Effect Monsters that activate in the hand or on the field cannot be activated.
--[[ __CARD_HEADER_END__ ]]

--暴君の暴言
function c76721030.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c76721030.cost)
	c:RegisterEffect(e1)
	--cannot trigger
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(1,1)
	e2:SetValue(c76721030.aclimit)
	c:RegisterEffect(e2)
end
function c76721030.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,2,nil) end
	local rg=Duel.SelectReleaseGroup(tp,nil,2,2,nil)
	Duel.Release(rg,REASON_COST)
end
function c76721030.aclimit(e,re,tp)
	local loc=re:GetActivateLocation()
	return (loc==LOCATION_MZONE or loc==LOCATION_HAND) and re:IsActiveType(TYPE_MONSTER)
end
