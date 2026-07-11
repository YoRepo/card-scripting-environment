--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Diced Dice  (ID: 93078761)
-- Type: Spell / Quick-Play
-- Scope: OCG / TCG
--
-- Effect Text:
-- Roll a six-sided die, and if you roll a 1 or 6, add 1 card from your Deck to your hand that requires
-- a die roll.
-- If you roll a number other than 1 or 6, roll it again, and apply the appropriate effect.
-- ● 1 or 6: Return this card to the hand.
-- ● 2, 3, 4, or 5: Place this card on top of the Deck.
-- You can only activate 1 "Diced Dice" per turn.
--[[ __CARD_HEADER_END__ ]]

--賽挑戦
function c93078761.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DICE+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCountLimit(1,93078761+EFFECT_COUNT_CODE_OATH)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c93078761.target)
	e1:SetOperation(c93078761.activate)
	c:RegisterEffect(e1)
end
function c93078761.filter(c)
	return c:IsEffectProperty(aux.EffectPropertyFilter(EFFECT_FLAG_DICE)) and c:IsAbleToHand()
end
function c93078761.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c93078761.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c93078761.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local dice1=Duel.TossDice(tp,1)
	if (dice1==1 or dice1==6) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local tc=Duel.SelectMatchingCard(tp,c93078761.filter,tp,LOCATION_DECK,0,1,1,nil):GetFirst()
		if tc then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		end
		return
	elseif c:IsRelateToEffect(e) then
		local dice2=Duel.TossDice(tp,1)
		if (dice2==1 or dice2==6) then
			c:CancelToGrave()
			Duel.SendtoHand(c,nil,REASON_EFFECT)
		elseif dice2>=2 and dice2<=5 then
			c:CancelToGrave()
			Duel.SendtoDeck(c,nil,SEQ_DECKTOP,REASON_EFFECT)
		end
	end
end
