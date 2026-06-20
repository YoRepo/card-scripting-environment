--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 告知幸运的白鸮  (ID: 23927567)
-- Type: Monster / Effect / Toon
-- Attribute: WIND
-- Race: Winged Beast
-- Level 2
-- ATK 300 | DEF 500
--
-- Effect Text:
-- 反转：从卡组中选择1张场地魔法卡，放在自己卡组最上面。当「王家长眠之谷」在场上存在时，可以将选择的场地魔法卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--幸運を告げるフクロウ
function c23927567.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c23927567.operation)
	c:RegisterEffect(e1)
end
function c23927567.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(23927567,1))
	local g=Duel.SelectMatchingCard(tp,Card.IsType,tp,LOCATION_DECK,0,1,1,nil,TYPE_FIELD)
	local tc=g:GetFirst()
	if tc then
		if Duel.IsEnvironment(47355498) and tc:IsAbleToHand() and Duel.SelectOption(tp,1190,aux.Stringid(23927567,0))==0 then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		else
			Duel.ShuffleDeck(tp)
			Duel.MoveSequence(tc,SEQ_DECKTOP)
			Duel.ConfirmDecktop(tp,1)
		end
	end
end
