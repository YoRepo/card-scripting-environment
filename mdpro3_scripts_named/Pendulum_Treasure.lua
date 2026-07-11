--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Pendulum Treasure  (ID: 26237713)
-- Type: Spell
-- Setcode: 0xf2
-- Scope: OCG / TCG
--
-- Effect Text:
-- Add 1 Pendulum Monster from your Deck to your Extra Deck face-up.
-- You can only activate 1 "Pendulum Treasure" per turn.
--[[ __CARD_HEADER_END__ ]]

--ペンデュラム・トレジャー
function c26237713.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOEXTRA)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,26237713+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c26237713.target)
	e1:SetOperation(c26237713.activate)
	c:RegisterEffect(e1)
end
function c26237713.filter(c)
	return c:IsType(TYPE_PENDULUM)
end
function c26237713.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c26237713.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,nil,1,tp,LOCATION_DECK)
end
function c26237713.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(26237713,0))
	local g=Duel.SelectMatchingCard(tp,c26237713.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoExtraP(g,nil,REASON_EFFECT)
	end
end
