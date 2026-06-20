--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 薰风的神官 穆斯托  (ID: 9837195)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Psychic
-- Level 4
-- ATK 1800 | DEF 900
-- Setcode: 16
--
-- Effect Text:
-- 可以选择自己墓地存在的1只名字带有「薰风」的怪兽回到卡组，选择场上表侧表示存在的1只怪兽把那个效果直到结束阶段时无效。这个效果1回合只能发动1次。
--[[ __CARD_HEADER_END__ ]]

--ガスタの神官 ムスト
function c9837195.initial_effect(c)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9837195,0))
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c9837195.target)
	e1:SetOperation(c9837195.operation)
	c:RegisterEffect(e1)
end
function c9837195.filter1(c)
	return c:IsSetCard(0x10) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeck()
end
function c9837195.filter2(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT)
end
function c9837195.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c9837195.filter1,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.IsExistingTarget(c9837195.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g1=Duel.SelectTarget(tp,c9837195.filter1,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g2=Duel.SelectTarget(tp,c9837195.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g1,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g2,1,0,0)
end
function c9837195.operation(e,tp,eg,ep,ev,re,r,rp)
	local ex,g1=Duel.GetOperationInfo(0,CATEGORY_TODECK)
	local ex,g2=Duel.GetOperationInfo(0,CATEGORY_DISABLE)
	if g1:GetFirst():IsRelateToEffect(e) then
		Duel.SendtoDeck(g1,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
	local tc=g2:GetFirst()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
	end
end
