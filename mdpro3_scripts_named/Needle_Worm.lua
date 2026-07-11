--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Needle Worm  (ID: 81843628)
-- Type: Monster / Effect / Flip
-- Attribute: EARTH
-- Race: Insect
-- Level: 2
-- ATK 750 | DEF 600
-- Setcode: 0x3e
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: Send the top 5 cards of your opponent's Deck to the GY.
--[[ __CARD_HEADER_END__ ]]

--ニードルワーム
function c81843628.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(81843628,0))
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c81843628.target)
	e1:SetOperation(c81843628.operation)
	c:RegisterEffect(e1)
end
function c81843628.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,1-tp,5)
end
function c81843628.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(1-tp,5,REASON_EFFECT)
end
