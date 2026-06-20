--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 苦涩的选择  (ID: 74191942)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 从卡组选择5张卡给对方看。对方从这些卡中选择1张。对方选择的卡加入自己手卡，其他的卡丢弃去墓地。
--[[ __CARD_HEADER_END__ ]]

--苦渋の選択
function c74191942.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c74191942.target)
	e1:SetOperation(c74191942.activate)
	c:RegisterEffect(e1)
end
function c74191942.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1)
		and Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,LOCATION_DECK,0,5,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c74191942.activate(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(74191942,0))
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,LOCATION_DECK,0,5,5,nil)
	if g:GetCount()<5 then return end
	Duel.ConfirmCards(1-tp,g)
	Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(74191942,1))
	local sg=g:Select(1-tp,1,1,nil)
	sg:GetFirst():SetStatus(STATUS_TO_HAND_WITHOUT_CONFIRM,true)
	Duel.SendtoHand(sg,nil,REASON_EFFECT)
	g:Sub(sg)
	Duel.SendtoGrave(g,REASON_EFFECT)
end
