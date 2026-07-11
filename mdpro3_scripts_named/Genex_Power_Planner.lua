--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Genex Power Planner  (ID: 30399511)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level: 1
-- ATK 300 | DEF 200
-- Setcode: 0x2
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Normal Summoned: You can add 1 Level 3 "Genex" Effect Monster from your Deck to
-- your hand.
--[[ __CARD_HEADER_END__ ]]

--ジェネクス・パワー・プランナー
function c30399511.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(30399511,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c30399511.target)
	e1:SetOperation(c30399511.operation)
	c:RegisterEffect(e1)
end
function c30399511.filter(c)
	return c:IsLevel(3) and c:IsSetCard(0x2) and c:IsType(TYPE_EFFECT) and c:IsAbleToHand()
end
function c30399511.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c30399511.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c30399511.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c30399511.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
