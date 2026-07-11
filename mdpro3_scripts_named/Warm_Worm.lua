--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Warm Worm  (ID: 16751086)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Insect
-- Level: 3
-- ATK 600 | DEF 1400
-- Setcode: 0x3e
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is destroyed, send the top 3 cards of your opponent's Deck to the Graveyard.
--[[ __CARD_HEADER_END__ ]]

--ウォーム・ワーム
function c16751086.initial_effect(c)
	--deckdes
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16751086,0))
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetTarget(c16751086.target)
	e1:SetOperation(c16751086.operation)
	c:RegisterEffect(e1)
end
function c16751086.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,1-tp,3)
end
function c16751086.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(1-tp,3,REASON_EFFECT)
end
