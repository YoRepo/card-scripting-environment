--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 传承的大御巫  (ID: 44649322)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 397
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：从手卡把1只「御巫」怪兽无视召唤条件特殊召唤。这个效果特殊召唤的怪兽在对方结束阶段回到手卡。
-- ②：自己主要阶段把墓地的这张卡除外才能发动。从卡组把「传承的大御巫」以外的1张「御巫」卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--伝承の大御巫
function c44649322.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44649322,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,44649322)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetTarget(c44649322.target)
	e1:SetOperation(c44649322.activate)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44649322,1))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,44649323)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c44649322.tgtg)
	e2:SetOperation(c44649322.tgop)
	c:RegisterEffect(e2)
end
function c44649322.filter(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x18d) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c44649322.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c44649322.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c44649322.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c44649322.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEUP) then
		local fid=e:GetHandler():GetFieldID()
		tc:RegisterFlagEffect(44649322,RESET_EVENT+RESETS_STANDARD,0,1,fid)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetLabel(fid)
		e1:SetLabelObject(tc)
		e1:SetCondition(c44649322.thcon)
		e1:SetOperation(c44649322.thop)
		Duel.RegisterEffect(e1,tp)
	end
	Duel.SpecialSummonComplete()
end
function c44649322.thcon(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()~=1-tp then return false end
	local tc=e:GetLabelObject()
	if tc:GetFlagEffectLabel(44649322)==e:GetLabel() then
		return true
	else
		e:Reset()
		return false
	end
end
function c44649322.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.SendtoHand(tc,nil,REASON_EFFECT)
end
function c44649322.tgfilter(c)
	return c:IsSetCard(0x18d) and not c:IsCode(44649322) and c:IsAbleToGrave()
end
function c44649322.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44649322.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c44649322.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44649322.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
