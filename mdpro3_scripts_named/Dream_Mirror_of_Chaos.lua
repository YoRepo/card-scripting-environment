--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 混沌之梦魔镜  (ID: 98570539)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 305
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：「梦魔镜」融合怪兽卡决定的融合素材怪兽从自己场上送去墓地，把那1只融合怪兽从额外卡组融合召唤。场地区域有「圣光之梦魔镜」存在的场合，手卡的怪兽也能作为融合素材。场地区域有「黯黑之梦魔镜」存在的场合
-- ，也能把自己墓地的怪兽除外作为融合素材。
--[[ __CARD_HEADER_END__ ]]

--混沌の夢魔鏡
function c98570539.initial_effect(c)
	aux.AddCodeList(c,74665651,1050355)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCountLimit(1,98570539+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c98570539.target)
	e1:SetOperation(c98570539.activate)
	c:RegisterEffect(e1)
end
function c98570539.filter0(c)
	return c:IsType(TYPE_MONSTER) and c:IsCanBeFusionMaterial() and c:IsAbleToRemove()
end
function c98570539.filter1(c,e)
	return not c:IsImmuneToEffect(e)
end
function c98570539.filter2(c,e,tp,m,f,chkf)
	return c:IsType(TYPE_FUSION) and c:IsSetCard(0x131) and (not f or f(c)) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,nil,chkf)
end
function c98570539.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local chkf=tp
		local mg1=Duel.GetFusionMaterial(tp):Filter(Card.IsOnField,nil)
		local mg2=nil
		if Duel.IsEnvironment(74665651,PLAYER_ALL,LOCATION_FZONE) then
			mg2=Duel.GetFusionMaterial(tp):Filter(Card.IsLocation,nil,LOCATION_HAND)
			mg1:Merge(mg2)
		end
		if Duel.IsEnvironment(1050355,PLAYER_ALL,LOCATION_FZONE) then
			mg2=Duel.GetMatchingGroup(c98570539.filter0,tp,LOCATION_GRAVE,0,nil)
			mg1:Merge(mg2)
		end
		local res=Duel.IsExistingMatchingCard(c98570539.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,chkf)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg3=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(c98570539.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg3,mf,chkf)
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,0,tp,LOCATION_GRAVE)
end
function c98570539.activate(e,tp,eg,ep,ev,re,r,rp)
	local chkf=tp
	local mg1=Duel.GetFusionMaterial(tp):Filter(Card.IsOnField,nil):Filter(c98570539.filter1,nil,e)
	local mg2=nil
	if Duel.IsEnvironment(74665651,PLAYER_ALL,LOCATION_FZONE) then
		mg2=Duel.GetFusionMaterial(tp):Filter(Card.IsLocation,nil,LOCATION_HAND)
		mg1:Merge(mg2)
	end
	if Duel.IsEnvironment(1050355,PLAYER_ALL,LOCATION_FZONE) then
		mg2=Duel.GetMatchingGroup(c98570539.filter0,tp,LOCATION_GRAVE,0,nil)
		mg1:Merge(mg2)
	end
	local sg1=Duel.GetMatchingGroup(c98570539.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
	local mg3=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg3=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(c98570539.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg3,mf,chkf)
	end
	if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
			local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,nil,chkf)
			tc:SetMaterial(mat1)
			local mat2=mat1:Filter(Card.IsLocation,nil,LOCATION_GRAVE)
			mat1:Sub(mat2)
			Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.Remove(mat2,POS_FACEUP,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		else
			local mat2=Duel.SelectFusionMaterial(tp,tc,mg3,nil,chkf)
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat2)
		end
		tc:CompleteProcedure()
	end
end
