--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 第五幕之希望  (ID: 55428811)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 选择自己墓地存在的5张名字带有「元素英雄」的卡，加入卡组洗切。之后，从自己卡组抽2张卡。这张卡的发动时自己场上以及手卡没有其他卡存在的场合抽3张卡。
--[[ __CARD_HEADER_END__ ]]

--ホープ・オブ・フィフス
function c55428811.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c55428811.target)
	e1:SetOperation(c55428811.activate)
	c:RegisterEffect(e1)
end
function c55428811.filter(c)
	return c:IsSetCard(0x3008) and c:IsAbleToDeck()
end
function c55428811.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c55428811.filter(chkc) end
	local dc=2
	if not Duel.IsExistingMatchingCard(nil,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,e:GetHandler()) then dc=3 end
	if chk==0 then return Duel.IsPlayerCanDraw(tp,dc)
		and Duel.IsExistingTarget(c55428811.filter,tp,LOCATION_GRAVE,0,5,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c55428811.filter,tp,LOCATION_GRAVE,0,5,5,nil)
	e:SetLabel(dc)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,dc)
end
function c55428811.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not tg or tg:FilterCount(Card.IsRelateToEffect,nil,e)~=5 then return end
	Duel.SendtoDeck(tg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	local g=Duel.GetOperatedGroup()
	if g:IsExists(Card.IsLocation,1,nil,LOCATION_DECK) then Duel.ShuffleDeck(tp) end
	local ct=g:FilterCount(Card.IsLocation,nil,LOCATION_DECK+LOCATION_EXTRA)
	if ct==5 then
		Duel.BreakEffect()
		Duel.Draw(tp,e:GetLabel(),REASON_EFFECT)
	end
end
