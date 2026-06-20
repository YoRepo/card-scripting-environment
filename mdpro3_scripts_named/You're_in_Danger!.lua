--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 未界域的欢待  (ID: 10312660)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 286
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从卡组把「未界域」怪兽3种类给对方观看，对方从那之中随机选1只。那1只怪兽在自己场上特殊召唤，剩下的怪兽回到卡组。这个效果特殊召唤的怪兽在结束阶段破坏。
--[[ __CARD_HEADER_END__ ]]

--未界域の歓待
function c10312660.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCountLimit(1,10312660+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c10312660.target)
	e1:SetOperation(c10312660.activate)
	c:RegisterEffect(e1)
end
function c10312660.spfilter(c,e,tp)
	return c:IsSetCard(0x11e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c10312660.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local dg=Duel.GetMatchingGroup(c10312660.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
		return dg:GetClassCount(Card.GetCode)>=3 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c10312660.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c10312660.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or g:GetClassCount(Card.GetCode)<3 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local sg=g:SelectSubGroup(tp,aux.dncheck,false,3,3)
	if sg then
		Duel.ConfirmCards(1-tp,sg)
		local tc=sg:RandomSelect(1-tp,1):GetFirst()
		Duel.ConfirmCards(tp,tc)
		if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0 then
			local fid=tc:GetFieldID()
			tc:RegisterFlagEffect(10312660,RESET_EVENT+RESETS_STANDARD,0,1,fid)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_PHASE+PHASE_END)
			e1:SetCountLimit(1)
			e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetLabel(fid)
			e1:SetLabelObject(tc)
			e1:SetCondition(c10312660.descon)
			e1:SetOperation(c10312660.desop)
			Duel.RegisterEffect(e1,tp)
		end
		Duel.ShuffleDeck(tp)
	end
end
function c10312660.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:GetFlagEffectLabel(10312660)~=e:GetLabel() then
		e:Reset()
		return false
	else
		return true
	end
end
function c10312660.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.Destroy(tc,REASON_EFFECT)
end
