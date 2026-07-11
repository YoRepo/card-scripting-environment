--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Spellbook of Secrets  (ID: 89739383)
-- Type: Spell
-- Setcode: 0x106e
-- Scope: OCG / TCG
--
-- Effect Text:
-- Add 1 "Spellbook" card from your Deck to your hand, except "Spellbook of Secrets".
-- You can only activate 1 "Spellbook of Secrets" per turn.
--[[ __CARD_HEADER_END__ ]]

--グリモの魔導書
function c89739383.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,89739383+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c89739383.target)
	e1:SetOperation(c89739383.activate)
	c:RegisterEffect(e1)
end
function c89739383.filter(c)
	return c:IsSetCard(0x106e) and not c:IsCode(89739383) and c:IsAbleToHand()
end
function c89739383.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c89739383.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c89739383.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c89739383.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
