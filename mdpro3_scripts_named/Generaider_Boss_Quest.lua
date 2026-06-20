--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 王战的试练  (ID: 75448086)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 308
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：手卡1只「王战」怪兽给对方观看，从卡组把「王战的试练」以外的最多2张「王战」魔法·陷阱卡加入手卡（同名卡最多1张）。那之后，给人观看的卡回到卡组最下面。
--[[ __CARD_HEADER_END__ ]]

--王の試練
function c75448086.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,75448086+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c75448086.target)
	e1:SetOperation(c75448086.activate)
	c:RegisterEffect(e1)
end
function c75448086.filter1(c)
	return c:IsSetCard(0x134) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeck() and not c:IsPublic()
end
function c75448086.filter2(c)
	return c:IsSetCard(0x134) and c:IsType(TYPE_SPELL+TYPE_TRAP) and not c:IsCode(75448086) and c:IsAbleToHand()
end
function c75448086.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c75448086.filter1,tp,LOCATION_HAND,0,1,nil)
		and Duel.IsExistingMatchingCard(c75448086.filter2,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c75448086.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g1=Duel.SelectMatchingCard(tp,c75448086.filter1,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g1)
	if g1:GetCount()==0 then return end
	local g2=Duel.GetMatchingGroup(c75448086.filter2,tp,LOCATION_DECK,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g2:SelectSubGroup(tp,aux.dncheck,false,1,2)
	if sg and Duel.SendtoHand(sg,nil,REASON_EFFECT)~=0 then
		Duel.ConfirmCards(1-tp,sg)
		Duel.ShuffleDeck(tp)
		Duel.BreakEffect()
		Duel.SendtoDeck(g1,nil,SEQ_DECKBOTTOM,REASON_EFFECT)
	end
end
