--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Aquaactress Arowana  (ID: 92053608)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level: 6
-- ATK 2000 | DEF 2000
-- Setcode: 0xcd
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn: You can add 1 "Aquaactress" monster from your Deck to your hand.
--[[ __CARD_HEADER_END__ ]]

--アクアアクトレス・アロワナ
function c92053608.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c92053608.thtg)
	e1:SetOperation(c92053608.thop)
	c:RegisterEffect(e1)
end
function c92053608.filter(c)
	return c:IsSetCard(0xcd) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c92053608.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92053608.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c92053608.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c92053608.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
