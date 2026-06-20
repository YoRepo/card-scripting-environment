--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 森罗的恩惠  (ID: 91650245)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 144
--
-- Effect Text:
-- 选1张手卡回到持有者卡组最上面或者最下面，从自己的手卡·墓地选1只名字带有「森罗」的怪兽特殊召唤。这个效果特殊召唤的怪兽在这个回合不受这张卡以外的卡的效果影响，结束阶段时回到持有者卡组最上面或者最下面
-- 。
--[[ __CARD_HEADER_END__ ]]

--森羅の恵み
function c91650245.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c91650245.target)
	e1:SetOperation(c91650245.activate)
	c:RegisterEffect(e1)
end
function c91650245.filter(c,e,tp)
	return c:IsAbleToDeck() and Duel.IsExistingMatchingCard(c91650245.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,c,e,tp)
end
function c91650245.spfilter(c,e,tp)
	return c:IsSetCard(0x90) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c91650245.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c91650245.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c91650245.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c91650245.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		local opt=Duel.SelectOption(tp,aux.Stringid(91650245,0),aux.Stringid(91650245,1))
		Duel.SendtoDeck(g,nil,opt,REASON_EFFECT)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c91650245.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,tc,e,tp)
		local sc=sg:GetFirst()
		if sc then
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCountLimit(1)
			e1:SetCode(EVENT_PHASE+PHASE_END)
			e1:SetOperation(c91650245.tdop)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			sc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e2:SetRange(LOCATION_MZONE)
			e2:SetCode(EFFECT_IMMUNE_EFFECT)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			e2:SetValue(c91650245.efilter)
			sc:RegisterEffect(e2)
		end
	end
end
function c91650245.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsExtraDeckMonster()
		or Duel.SelectOption(tp,aux.Stringid(91650245,0),aux.Stringid(91650245,1))==0 then
		Duel.SendtoDeck(c,nil,SEQ_DECKTOP,REASON_EFFECT)
	else
		Duel.SendtoDeck(c,nil,SEQ_DECKBOTTOM,REASON_EFFECT)
	end
end
function c91650245.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
