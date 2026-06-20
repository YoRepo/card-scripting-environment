--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 来自农园的配送  (ID: 27001740)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己场上有通常怪兽存在的场合，以除外的最多3只自己的通常怪兽为对象才能发动。那些怪兽回到卡组。
--[[ __CARD_HEADER_END__ ]]

--農園からの配送
function c27001740.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c27001740.condition)
	e1:SetTarget(c27001740.target)
	e1:SetOperation(c27001740.activate)
	c:RegisterEffect(e1)
end
function c27001740.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_NORMAL)
end
function c27001740.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c27001740.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c27001740.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_NORMAL) and c:IsAbleToDeck()
end
function c27001740.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c27001740.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c27001740.filter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c27001740.filter,tp,LOCATION_REMOVED,0,1,3,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c27001740.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
end
