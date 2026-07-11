--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Voltic Bicorn  (ID: 13995824)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Beast
-- Level: 7
-- ATK 2500 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Beast-Type Tuner + 1 or more non-Tuner monsters
-- If this card is destroyed by your opponent's card (either by battle or by card effect), both players
-- send the top 7 cards of their Deck to the Graveyard.
--[[ __CARD_HEADER_END__ ]]

--ボルテック・バイコーン
function c13995824.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_BEAST),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--deckdes
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13995824,0))
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c13995824.ddcon)
	e1:SetTarget(c13995824.ddtg)
	e1:SetOperation(c13995824.ddop)
	c:RegisterEffect(e1)
end
function c13995824.ddcon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and e:GetHandler():IsPreviousControler(tp)
end
function c13995824.ddtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,0,0,PLAYER_ALL,7)
end
function c13995824.ddop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(tp,7,REASON_EFFECT)
	Duel.DiscardDeck(1-tp,7,REASON_EFFECT)
end
