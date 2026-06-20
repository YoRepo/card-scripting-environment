--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 七音服的交响曲  (ID: 56510115)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 354
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：自己的额外卡组的表侧表示的「七音服」灵摆怪兽种类的以下效果适用。
-- ●3种类以上：这个回合，自己场上的「七音服」灵摆怪兽的攻击力上升自身的灵摆刻度×300。
-- ●5种类以上：可以选对方场上1张卡破坏。自己的灵摆区域有奇数的灵摆刻度存在的场合，再让自己从卡组抽1张。
-- ●7种类以上：可以从额外卡组把1只「大钢琴之七音服」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ドレミコード・シンフォニア
function c56510115.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCountLimit(1,56510115+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(aux.dscon)
	e1:SetTarget(c56510115.target)
	e1:SetOperation(c56510115.operation)
	c:RegisterEffect(e1)
end
function c56510115.cfilter(c)
	return c:IsSetCard(0x162) and c:IsType(TYPE_PENDULUM) and c:IsFaceup()
end
function c56510115.slfilter(c)
	local scal=c:GetCurrentScale()
	return scal>0 and scal%2==1
end
function c56510115.spfilter(c,e,tp)
	return c:IsSetCard(0x1162) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function c56510115.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=Duel.GetMatchingGroup(c56510115.cfilter,tp,LOCATION_EXTRA,0,nil)
		local ct=g:GetClassCount(Card.GetCode)
		return ct>=3
	end
end
function c56510115.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c56510115.cfilter,tp,LOCATION_EXTRA,0,nil)
	local ct=g:GetClassCount(Card.GetCode)
	local draw=Duel.IsExistingMatchingCard(c56510115.slfilter,tp,LOCATION_PZONE,0,1,nil) and Duel.IsPlayerCanDraw(tp,1)
	local b1=ct>=3
	local b2=ct>=5 and Duel.IsExistingMatchingCard(nil,tp,0,LOCATION_ONFIELD,1,nil)
	local b3=ct>=7 and Duel.IsExistingMatchingCard(c56510115.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp)
	if b1 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetTargetRange(LOCATION_MZONE,0)
		e1:SetTarget(c56510115.atktg)
		e1:SetValue(c56510115.atkval)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
	if b2 and Duel.SelectYesNo(tp,aux.Stringid(56510115,1)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local dg=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,1,nil)
		Duel.HintSelection(dg)
		if #dg>0 and Duel.Destroy(dg,REASON_EFFECT)>0 and draw then
			Duel.BreakEffect()
			Duel.Draw(tp,1,REASON_EFFECT)
		end
	end
	if b3 and Duel.SelectYesNo(tp,aux.Stringid(56510115,2)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=Duel.SelectMatchingCard(tp,c56510115.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
		if #sg==0 then return end
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c56510115.atktg(e,c)
	return c:IsType(TYPE_PENDULUM) and c:IsSetCard(0x162)
end
function c56510115.atkval(e,c)
	return c:GetCurrentScale()*300
end
