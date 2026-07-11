--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Gem-Turtle  (ID: 64734090)
-- Type: Monster / Effect / Flip
-- Attribute: EARTH
-- Race: Rock
-- Level: 4
-- ATK 0 | DEF 2000
-- Setcode: 0x47
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: You can add 1 "Gem-Knight Fusion" from your Deck to your hand.
--[[ __CARD_HEADER_END__ ]]

--ジェムタートル
function c64734090.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(64734090,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(c64734090.tg)
	e1:SetOperation(c64734090.op)
	c:RegisterEffect(e1)
end
function c64734090.filter(c)
	return c:IsCode(1264319) and c:IsAbleToHand()
end
function c64734090.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c64734090.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c64734090.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c64734090.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
