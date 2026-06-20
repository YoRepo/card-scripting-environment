--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 大薰风翔鹏  (ID: 84766279)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Psychic
-- Level 5
-- ATK 2200 | DEF 800
-- Setcode: 16
--
-- Effect Text:
-- 调整＋调整以外的名字带有「薰风」的怪兽1只以上
-- 1回合1次，可以让自己墓地存在的2只名字带有「薰风」的怪兽回到卡组，选择对方场上表侧表示存在的1只怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--ダイガスタ・ガルドス
function c84766279.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsSetCard,0x10),1)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(84766279,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c84766279.cost)
	e1:SetTarget(c84766279.target)
	e1:SetOperation(c84766279.operation)
	c:RegisterEffect(e1)
end
function c84766279.costfilter(c)
	return c:IsSetCard(0x10) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeckAsCost()
end
function c84766279.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c84766279.costfilter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c84766279.costfilter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.HintSelection(g)
	Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_COST)
end
function c84766279.filter(c)
	return c:IsFaceup()
end
function c84766279.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c84766279.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c84766279.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c84766279.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c84766279.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
