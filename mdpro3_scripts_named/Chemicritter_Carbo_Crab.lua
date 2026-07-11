--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Chemicritter Carbo Crab  (ID: 81599449)
-- Type: Monster / Effect / Gemini
-- Attribute: FIRE
-- Race: Aqua
-- Level: 2
-- ATK 700 | DEF 1400
-- Setcode: 0xeb
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is treated as a Normal Monster while face-up on the field or in the Graveyard.
-- While this card is a Normal Monster on the field, you can Normal Summon it to have it become an
-- Effect Monster with this effect.
-- ● During your Main Phase: You can send 1 Gemini monster from your Deck to the Graveyard, then add 1
-- Gemini monster from your Deck to your hand.
-- You can only use this effect of "Chemicritter Carbo Crab" once per turn.
--[[ __CARD_HEADER_END__ ]]

--化合獣カーボン・クラブ
function c81599449.initial_effect(c)
	aux.EnableDualAttribute(c)
	--to grave/search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(81599449,0))
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,81599449)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(aux.IsDualState)
	e1:SetTarget(c81599449.tgtg)
	e1:SetOperation(c81599449.tgop)
	c:RegisterEffect(e1)
end
function c81599449.filter(c,tp)
	return c:IsType(TYPE_DUAL) and c:IsAbleToGrave()
		and Duel.IsExistingMatchingCard(c81599449.thfilter,tp,LOCATION_DECK,0,1,c)
end
function c81599449.tgfilter(c)
	return c:IsType(TYPE_DUAL) and c:IsAbleToGrave()
end
function c81599449.thfilter(c)
	return c:IsType(TYPE_DUAL) and c:IsAbleToHand()
end
function c81599449.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c81599449.filter,tp,LOCATION_DECK,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c81599449.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c81599449.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 and Duel.SendtoGrave(g,REASON_EFFECT)~=0
		and g:GetFirst():IsLocation(LOCATION_GRAVE) then
		local sg=Duel.GetMatchingGroup(c81599449.thfilter,tp,LOCATION_DECK,0,nil)
		if sg:GetCount()>0 then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local tg=sg:Select(tp,1,1,nil)
			Duel.SendtoHand(tg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tg)
		end
	end
end
