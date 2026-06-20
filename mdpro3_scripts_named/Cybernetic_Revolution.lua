--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 电子革命  (ID: 18597560)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 148
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：把自己场上1只「电子龙」解放才能发动。以「电子龙」怪兽为融合素材的1只融合怪兽从额外卡组特殊召唤。这个效果特殊召唤的怪兽不能直接攻击，下个回合的结束阶段破坏。
--[[ __CARD_HEADER_END__ ]]

--サイバネティック・レボリューション
function c18597560.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,18597560+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c18597560.cost)
	e1:SetTarget(c18597560.target)
	e1:SetOperation(c18597560.activate)
	c:RegisterEffect(e1)
end
function c18597560.cfilter(c,e,tp)
	return c:IsCode(70095154) and Duel.IsExistingMatchingCard(c18597560.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c)
end
function c18597560.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c18597560.cfilter,1,nil,e,tp) end
	local g=Duel.SelectReleaseGroup(tp,c18597560.cfilter,1,1,nil,e,tp)
	Duel.Release(g,REASON_COST)
end
function c18597560.filter(c,e,tp,rc)
	return c:IsType(TYPE_FUSION) and aux.IsMaterialListSetCard(c,0x1093)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,rc,c)>0
end
function c18597560.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local res=e:GetLabel()==100
		e:SetLabel(0)
		return res or Duel.IsExistingMatchingCard(c18597560.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp,nil)
	end
	e:SetLabel(0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c18597560.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c18597560.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,nil):GetFirst()
	if tc and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		tc:RegisterFlagEffect(18597560,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,2)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetCondition(c18597560.descon)
		e2:SetOperation(c18597560.desop)
		e2:SetReset(RESET_PHASE+PHASE_END,2)
		e2:SetCountLimit(1)
		e2:SetLabel(Duel.GetTurnCount())
		e2:SetLabelObject(tc)
		Duel.RegisterEffect(e2,tp)
	end
	Duel.SpecialSummonComplete()
end
function c18597560.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return Duel.GetTurnCount()~=e:GetLabel() and tc:GetFlagEffect(18597560)~=0
end
function c18597560.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.Destroy(tc,REASON_EFFECT)
end
