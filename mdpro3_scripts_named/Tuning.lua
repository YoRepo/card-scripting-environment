--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 调律  (ID: 96363153)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：从卡组把1只「同调士」调整加入手卡。那之后，自己卡组最上面的卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--調律
function c96363153.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c96363153.target)
	e1:SetOperation(c96363153.activate)
	c:RegisterEffect(e1)
end
function c96363153.filter(c)
	return c:IsSetCard(0x1017) and c:IsType(TYPE_TUNER) and c:IsAbleToHand()
end
function c96363153.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1)
		and Duel.IsExistingMatchingCard(c96363153.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c96363153.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c96363153.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		Duel.ShuffleDeck(tp)
		Duel.BreakEffect()
		Duel.DiscardDeck(tp,1,REASON_EFFECT)
	end
end
