--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Bicorn Re'em  (ID: 58685438)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Beast
-- Level: 4
-- ATK 800 | DEF 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is sent to the Graveyard as a Synchro Material Monster for a Synchro Summon, send the
-- top 2 cards from your opponent's Deck to the Graveyard.
--[[ __CARD_HEADER_END__ ]]

--二角獣レーム
function c58685438.initial_effect(c)
	--deckdes
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(58685438,0))
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCondition(c58685438.ddcon)
	e1:SetTarget(c58685438.ddtg)
	e1:SetOperation(c58685438.ddop)
	c:RegisterEffect(e1)
end
function c58685438.ddcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO
end
function c58685438.ddtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,1-tp,2)
end
function c58685438.ddop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.DiscardDeck(p,2,REASON_EFFECT)
end
