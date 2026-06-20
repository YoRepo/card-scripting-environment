--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 破灭之光子流  (ID: 72044448)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 85
--
-- Effect Text:
-- 自己场上有名字带有「银河眼」的怪兽存在的场合才能发动。选择场上1张卡从游戏中除外。自己场上没有「银河眼光子龙」存在的场合，这张卡不在自己回合不能发动。
--[[ __CARD_HEADER_END__ ]]

--破滅のフォトン・ストリーム
function c72044448.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCondition(c72044448.condition)
	e1:SetTarget(c72044448.target)
	e1:SetOperation(c72044448.activate)
	c:RegisterEffect(e1)
end
function c72044448.cfilter1(c)
	return c:IsFaceup() and c:IsSetCard(0x107b)
end
function c72044448.cfilter2(c)
	return c:IsFaceup() and c:IsCode(93717133)
end
function c72044448.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c72044448.cfilter1,tp,LOCATION_MZONE,0,1,nil)
		and (Duel.GetTurnPlayer()==tp or Duel.IsExistingMatchingCard(c72044448.cfilter2,tp,LOCATION_ONFIELD,0,1,nil))
end
function c72044448.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c72044448.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
