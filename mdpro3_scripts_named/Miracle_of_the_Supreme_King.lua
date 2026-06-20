--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 霸王龙的奇迹  (ID: 40456412)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己场上有「霸王龙 扎克」存在的场合，可以从以下效果选择1个发动（这个卡名的以下效果1回合各能选择1次）。
-- ●自己场上1张「霸王龙 扎克」破坏，从卡组·额外卡组把1只「异色眼」灵摆怪兽或者光属性「霸王龙 扎克」无视召唤条件特殊召唤。
-- ●自己的额外卡组1只表侧的灵摆怪兽在自己的灵摆区域放置。
-- ●从卡组把1张速攻魔法卡在自己场上盖放。
--[[ __CARD_HEADER_END__ ]]

--覇王龍の奇跡
function c40456412.initial_effect(c)
	aux.AddCodeList(c,13331639)
	--select effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(40456412,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCondition(c40456412.condition)
	e1:SetTarget(c40456412.target)
	e1:SetOperation(c40456412.operation)
	c:RegisterEffect(e1)
end
function c40456412.cfilter(c)
	return c:IsCode(13331639) and c:IsFaceup()
end
function c40456412.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c40456412.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c40456412.desfilter(c)
	return c:IsCode(13331639) and c:IsFaceup()
end
function c40456412.spfilter(c,e,tp)
	return ((c:IsSetCard(0x99) and c:IsType(TYPE_PENDULUM)) or (c:IsCode(13331639) and c:IsAttribute(ATTRIBUTE_LIGHT)))
		and ((c:IsLocation(LOCATION_DECK) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0)
		or (c:IsLocation(LOCATION_EXTRA) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0))
		and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c40456412.psfilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsFaceup() and not c:IsForbidden()
end
function c40456412.ssfilter(c)
	return c:IsType(TYPE_QUICKPLAY) and c:IsSSetable()
end
function c40456412.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g1=Duel.GetMatchingGroup(c40456412.desfilter,tp,LOCATION_ONFIELD,0,nil)
	local g2=Duel.GetMatchingGroup(c40456412.spfilter,tp,LOCATION_DECK+LOCATION_EXTRA,0,nil,e,tp)
	local b1=(Duel.GetFlagEffect(tp,40456412+1)==0 or not e:IsCostChecked())
		and g1:GetCount()>0 and g2:GetCount()>0
	local b2=(Duel.GetFlagEffect(tp,40456412+2)==0 or not e:IsCostChecked())
		and (Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1))
		and Duel.IsExistingMatchingCard(c40456412.psfilter,tp,LOCATION_EXTRA,0,1,nil)
	local b3=(Duel.GetFlagEffect(tp,40456412+3)==0 or not e:IsCostChecked())
		and Duel.IsExistingMatchingCard(c40456412.ssfilter,tp,LOCATION_DECK,0,1,nil)
	if chk==0 then return b1 or b2 or b3 end
	local op=aux.SelectFromOptions(tp,
		{b1,aux.Stringid(40456412,1)},
		{b2,aux.Stringid(40456412,2)},
		{b3,aux.Stringid(40456412,3)})
	if e:IsCostChecked() then
		Duel.RegisterFlagEffect(tp,40456412+op,RESET_PHASE+PHASE_END,0,1)
	end
	e:SetLabel(op)
	if op==1 then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,1,0,0)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_EXTRA)
		if e:IsCostChecked() then
			e:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
		end
	elseif op==2 then
		if e:IsCostChecked() then
			e:SetCategory(0)
		end
	elseif op==3 then
		if e:IsCostChecked() then
			e:SetCategory(CATEGORY_SSET)
		end
	end
end
function c40456412.operation(e,tp,eg,ep,ev,re,r,rp)
	local op=e:GetLabel()
	if op==1 then
		c40456412.spop(e,tp,eg,ep,ev,re,r,rp)
	elseif op==2 then
		c40456412.psop(e,tp,eg,ep,ev,re,r,rp)
	elseif op==3 then
		c40456412.ssop(e,tp,eg,ep,ev,re,r,rp)
	end
end
function c40456412.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectMatchingCard(tp,c40456412.desfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	local g2=Duel.GetMatchingGroup(c40456412.spfilter,tp,LOCATION_DECK+LOCATION_EXTRA,0,nil,e,tp)
	if Duel.Destroy(g1,REASON_EFFECT)>0 and g2:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sc=g2:Select(tp,1,1,nil)
		Duel.SpecialSummon(sc,0,tp,tp,true,false,POS_FACEUP)
	end
end
function c40456412.psop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.CheckLocation(tp,LOCATION_PZONE,0) and not Duel.CheckLocation(tp,LOCATION_PZONE,1) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c40456412.psfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	local tc=g:GetFirst()
	if not tc then return end
	if Duel.MoveToField(tc,tp,tp,LOCATION_PZONE,POS_FACEUP,false) then
		tc:SetStatus(STATUS_EFFECT_ENABLED,true)
	end
end
function c40456412.ssop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c40456412.ssfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SSet(tp,g:GetFirst())
	end
end
