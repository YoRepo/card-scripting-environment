--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 蠢动于星遗物的陷阱  (ID: 16329071)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 254
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从自己的手卡·墓地的卡、自己场上的表侧表示的卡、除外的自己的卡之中选「蠢动于星遗物的陷阱」以外的「星遗物」卡5种类各1张，加入持有者卡组洗切。那之后，自己从卡组抽2张。
--[[ __CARD_HEADER_END__ ]]

--星遺物に蠢く罠
function c16329071.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,16329071+EFFECT_COUNT_CODE_OATH)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c16329071.target)
	e1:SetOperation(c16329071.activate)
	c:RegisterEffect(e1)
end
function c16329071.filter(c)
	return c:IsSetCard(0xfe) and not c:IsCode(16329071) and (c:IsLocation(LOCATION_HAND+LOCATION_GRAVE) or c:IsFaceup()) and c:IsAbleToDeck()
end
function c16329071.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c16329071.filter,tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_ONFIELD+LOCATION_REMOVED,0,nil)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2)
		and g:GetClassCount(Card.GetCode)>=5 end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,5,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c16329071.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c16329071.filter),tp,LOCATION_HAND+LOCATION_GRAVE+LOCATION_ONFIELD+LOCATION_REMOVED,0,nil)
	if g:GetClassCount(Card.GetCode)<5 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	aux.GCheckAdditional=aux.dncheck
	local sg=g:SelectSubGroup(tp,aux.TRUE,false,5,5)
	aux.GCheckAdditional=nil
	local cg=sg:Filter(Card.IsLocation,nil,LOCATION_HAND)
	if cg:GetCount()>0 then
		Duel.ConfirmCards(1-tp,cg)
	end
	Duel.SendtoDeck(sg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	local og=Duel.GetOperatedGroup()
	if og:IsExists(Card.IsLocation,1,nil,LOCATION_DECK) then Duel.ShuffleDeck(tp) end
	local ct=og:FilterCount(Card.IsLocation,nil,LOCATION_DECK+LOCATION_EXTRA)
	if ct==5 then
		Duel.BreakEffect()
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end
