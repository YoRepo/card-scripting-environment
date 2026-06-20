--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 大薰风天鹰  (ID: 10755984)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Psychic
-- Level 7
-- ATK 2600 | DEF 1800
-- Setcode: 16
--
-- Effect Text:
-- 调整＋调整以外的名字带有「薰风」的怪兽1只以上
-- 1回合1次，自己的结束阶段时可以从自己墓地把1只风属性怪兽从游戏中除外，选择对方场上里侧表示存在的1张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--ダイガスタ・イグルス
function c10755984.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsSetCard,0x10),1)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10755984,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c10755984.condition)
	e1:SetCost(c10755984.cost)
	e1:SetTarget(c10755984.target)
	e1:SetOperation(c10755984.operation)
	c:RegisterEffect(e1)
end
function c10755984.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c10755984.costfilter(c)
	return c:IsAttribute(ATTRIBUTE_WIND) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c10755984.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c10755984.costfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c10755984.costfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c10755984.filter(c)
	return c:IsFacedown()
end
function c10755984.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c10755984.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c10755984.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c10755984.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c10755984.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
