--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 第19层『袭来干涉！漆黑的超级量子战士！！』  (ID: 98349765)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 4316
--
-- Effect Text:
-- ①：可以从以下效果选择1个发动（这个卡名的以下效果1回合各能选择1次）。
-- ●以场上1只攻击表示怪兽为对象才能发动。那只怪兽变成守备表示。
-- ●自己场上有「超级量子」怪兽存在的场合才能发动。原本属性相同的怪兽不在自己场上存在的1只「超级量子」怪兽从卡组守备表示特殊召唤。
-- ●从卡组把1张「超级量子」陷阱卡在自己场上盖放。这个效果盖放的卡在盖放的回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--第19層『襲来干渉！漆黒の超量士！！』
local s,id,o=GetID()
function s.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_SPECIAL_SUMMON+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.posfilter(c)
	return c:IsAttackPos() and c:IsCanChangePosition()
end
function s.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xdc)
end
function s.attfilter(c,att)
	return c:IsFaceup() and c:GetOriginalAttribute()&att~=0
end
function s.spfilter(c,e,tp)
	return c:IsSetCard(0xdc) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
		and not Duel.IsExistingMatchingCard(s.attfilter,tp,LOCATION_MZONE,0,1,nil,c:GetOriginalAttribute())
end
function s.setfilter(c)
	return c:IsSetCard(0xdc) and c:IsType(TYPE_TRAP) and c:IsSSetable()
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return e:GetLabel()==1 and chkc:IsType(TYPE_MONSTER) and s.posfilter(chkc) end
	local ct=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) and not e:GetHandler():IsLocation(LOCATION_SZONE) then ct=ct-1 end
	local b1=Duel.IsExistingTarget(s.posfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
		and (not e:IsCostChecked() or Duel.GetFlagEffect(tp,id)==0)
	local b2=Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp)
		and (not e:IsCostChecked()
			or Duel.GetFlagEffect(tp,id+o)==0 and Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_MZONE,0,1,nil))
	local b3=ct>0 and Duel.IsExistingMatchingCard(s.setfilter,tp,LOCATION_DECK,0,1,nil)
		and (not e:IsCostChecked() or Duel.GetFlagEffect(tp,id+o*2)==0)
	if chk==0 then return b1 or b2 or b3 end
	local op=0
	if b1 or b2 or b3 then
		op=aux.SelectFromOptions(tp,
			{b1,aux.Stringid(id,1),1},
			{b2,aux.Stringid(id,2),2},
			{b3,aux.Stringid(id,3),3})
	end
	e:SetLabel(op)
	if op==1 then
		if e:IsCostChecked() then
			Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,0,1)
			e:SetCategory(CATEGORY_POSITION)
		end
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
		Duel.SelectTarget(tp,s.posfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	elseif op==2 then
		if e:IsCostChecked() then
			Duel.RegisterFlagEffect(tp,id+o,RESET_PHASE+PHASE_END,0,1)
			e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		end
		e:SetProperty(0)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
	elseif op==3 then
		if e:IsCostChecked() then
			Duel.RegisterFlagEffect(tp,id+o*2,RESET_PHASE+PHASE_END,0,1)
			e:SetCategory(CATEGORY_SSET)
		end
		e:SetProperty(0)
	end
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==1 then
		local tc=Duel.GetFirstTarget()
		if tc:IsRelateToChain() and tc:IsAttackPos() then
			Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)
		end
	elseif e:GetLabel()==2 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		end
	elseif e:GetLabel()==3 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
		local g=Duel.SelectMatchingCard(tp,s.setfilter,tp,LOCATION_DECK,0,1,1,nil)
		local tc=g:GetFirst()
		if tc and Duel.SSet(tp,tc)~=0 then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetDescription(aux.Stringid(id,4))
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
			e1:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e1)
		end
	end
end
