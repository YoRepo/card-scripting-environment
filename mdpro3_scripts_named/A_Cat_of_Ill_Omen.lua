--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 告知不幸的黑猫  (ID: 24140059)
-- Type: Monster / Effect / Toon
-- Attribute: DARK
-- Race: Beast
-- Level 2
-- ATK 500 | DEF 300
--
-- Effect Text:
-- ①：这张卡反转的场合发动。从卡组选1张陷阱卡在卡组最上面放置。「王家长眠之谷」在场上存在的场合，那张陷阱卡可以作为在卡组最上面放置的代替而加入手卡。
--[[ __CARD_HEADER_END__ ]]

--不幸を告げる黒猫
function c24140059.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c24140059.operation)
	c:RegisterEffect(e1)
end
function c24140059.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(24140059,1))
	local g=Duel.SelectMatchingCard(tp,Card.IsType,tp,LOCATION_DECK,0,1,1,nil,TYPE_TRAP)
	local tc=g:GetFirst()
	if tc then
		if Duel.IsEnvironment(47355498) and tc:IsAbleToHand() and Duel.SelectOption(tp,1190,aux.Stringid(24140059,0))==0 then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		else
			Duel.ShuffleDeck(tp)
			Duel.MoveSequence(tc,SEQ_DECKTOP)
			Duel.ConfirmDecktop(tp,1)
		end
	end
end
