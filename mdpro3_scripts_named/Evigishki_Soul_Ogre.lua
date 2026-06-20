--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 邪遗式灵魂食人魔  (ID: 57272170)
-- Type: Monster / Effect / Ritual
-- Attribute: WATER
-- Race: Aqua
-- Level 8
-- ATK 2800 | DEF 2800
-- Setcode: 58
--
-- Effect Text:
-- 名字带有「遗式」的仪式魔法卡降临。1回合1次，可以从手卡把1只名字带有「遗式」的怪兽丢弃，选择对方场上表侧表示存在的1张卡回到持有者卡组。
--[[ __CARD_HEADER_END__ ]]

--イビリチュア・ソウルオーガ
function c57272170.initial_effect(c)
	c:EnableReviveLimit()
	--return to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(57272170,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCost(c57272170.cost)
	e1:SetTarget(c57272170.target)
	e1:SetOperation(c57272170.operation)
	c:RegisterEffect(e1)
end
function c57272170.costfilter(c)
	return c:IsSetCard(0x3a) and c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c57272170.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c57272170.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c57272170.costfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c57272170.filter(c)
	return c:IsFaceup() and c:IsAbleToDeck()
end
function c57272170.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c57272170.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c57272170.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c57272170.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c57272170.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
