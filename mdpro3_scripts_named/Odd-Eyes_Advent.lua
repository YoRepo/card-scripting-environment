--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 异色眼降临  (ID: 16494704)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
-- Setcode: 153
--
-- Effect Text:
-- 龙族仪式怪兽的降临必需。这个卡名的卡在1回合只能发动1张。
-- ①：等级合计直到变成仪式召唤的怪兽的等级以上为止，把自己的手卡·场上的灵摆怪兽解放，从自己的手卡·墓地把1只龙族仪式怪兽仪式召唤。对方场上有怪兽2只以上存在，自己场上没有怪兽存在的场合，自己的额外卡组
-- 的「异色眼」怪兽也能作为解放的代替而送去墓地。
--[[ __CARD_HEADER_END__ ]]

--オッドアイズ・アドベント
function c16494704.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,16494704+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c16494704.target)
	e1:SetOperation(c16494704.operation)
	c:RegisterEffect(e1)
end
function c16494704.exfilter0(c)
	return c:IsSetCard(0x99) and c:IsLevelAbove(1) and c:IsAbleToGrave()
end
function c16494704.filter(c,e,tp)
	return c:IsRace(RACE_DRAGON)
end
function c16494704.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local mg=Duel.GetRitualMaterial(tp):Filter(Card.IsType,nil,TYPE_PENDULUM)
		local sg=nil
		if Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0 and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>1 then
			sg=Duel.GetMatchingGroup(c16494704.exfilter0,tp,LOCATION_EXTRA,0,nil)
		end
		return Duel.IsExistingMatchingCard(aux.RitualUltimateFilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,c16494704.filter,e,tp,mg,sg,Card.GetLevel,"Greater")
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c16494704.operation(e,tp,eg,ep,ev,re,r,rp)
	::cancel::
	local mg=Duel.GetRitualMaterial(tp):Filter(Card.IsType,nil,TYPE_PENDULUM)
	local sg=nil
	if Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0 and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>1 then
		sg=Duel.GetMatchingGroup(c16494704.exfilter0,tp,LOCATION_EXTRA,0,nil)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(aux.RitualUltimateFilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,c16494704.filter,e,tp,mg,sg,Card.GetLevel,"Greater")
	local tc=tg:GetFirst()
	if tc then
		mg=mg:Filter(Card.IsCanBeRitualMaterial,tc,tc)
		if sg then
			mg:Merge(sg)
		end
		if tc.mat_filter then
			mg=mg:Filter(tc.mat_filter,tc,tp)
		else
			mg:RemoveCard(tc)
		end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		aux.GCheckAdditional=aux.RitualCheckAdditional(tc,tc:GetLevel(),"Greater")
		local mat=mg:SelectSubGroup(tp,aux.RitualCheck,true,1,tc:GetLevel(),tp,tc,tc:GetLevel(),"Greater")
		aux.GCheckAdditional=nil
		if not mat then goto cancel end
		tc:SetMaterial(mat)
		local mat2=mat:Filter(Card.IsLocation,nil,LOCATION_EXTRA)
		mat:Sub(mat2)
		Duel.ReleaseRitualMaterial(mat)
		Duel.SendtoGrave(mat2,REASON_EFFECT+REASON_MATERIAL+REASON_RITUAL)
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,false,true,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
