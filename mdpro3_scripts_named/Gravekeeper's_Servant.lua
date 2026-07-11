--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Gravekeeper's Servant  (ID: 16762927)
-- Type: Spell / Continuous
-- Setcode: 0x2e
-- Scope: OCG / TCG
--
-- Effect Text:
-- Unless your opponent sends 1 card from the top of his/her Deck to the Graveyard, he/she cannot
-- declare an attack.
--[[ __CARD_HEADER_END__ ]]

--墓守の使い魔
function c16762927.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--attack cost
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_ATTACK_COST)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(0,1)
	e2:SetCost(c16762927.atcost)
	e2:SetOperation(c16762927.atop)
	c:RegisterEffect(e2)
	--accumulate
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_FLAG_EFFECT+16762927)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(0,1)
	c:RegisterEffect(e3)
end
function c16762927.atcost(e,c,tp)
	local ct=Duel.GetFlagEffect(tp,16762927)
	return Duel.IsPlayerCanDiscardDeckAsCost(tp,ct)
end
function c16762927.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(tp,1,REASON_COST)
end
