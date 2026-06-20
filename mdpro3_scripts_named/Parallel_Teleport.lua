--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 平行瞬间移动  (ID: 483)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 460
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张，这张卡发动的回合，自己不是念动力族怪兽不能特殊召唤。
-- ①：把自己场上1只持有等级的念动力族怪兽解放才能发动。从卡组·额外卡组把1只7星以下的念动力族怪兽特殊召唤。解放的怪兽和这个效果特殊召唤的怪兽的原本等级不同的场合，再让自己失去那个相差×1000基本分
-- 。
--[[ __CARD_HEADER_END__ ]]

--パラレル・テレポート
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCost(s.cost)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(id,ACTIVITY_SPSUMMON,s.counterfilter)
end
function s.counterfilter(c)
	return c:IsRace(RACE_PSYCHO)
end
function s.costfilter(c,e,tp)
	return c:IsRace(RACE_PSYCHO) and c:IsLevelAbove(1)
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,nil,e,tp,c)
end
function s.spfilter(c,e,tp,ec)
	return c:IsRace(RACE_PSYCHO) and c:IsLevelBelow(7) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and (c:IsLocation(LOCATION_DECK) and Duel.GetMZoneCount(tp,ec)>0
		or c:IsLocation(LOCATION_EXTRA) and Duel.GetLocationCountFromEx(tp,tp,ec,c)>0)
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(id,tp,ACTIVITY_SPSUMMON)==0
		and Duel.CheckReleaseGroup(tp,s.costfilter,1,nil,e,tp) end
	local g=Duel.SelectReleaseGroup(tp,s.costfilter,1,1,nil,e,tp)
	e:SetLabel(g:GetFirst():GetOriginalLevel())
	Duel.Release(g,REASON_COST)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetLabelObject(e)
	e1:SetTarget(s.splimit)
	Duel.RegisterEffect(e1,tp)
end
function s.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsRace(RACE_PSYCHO)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsCostChecked() end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_EXTRA)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0
		and tc:GetOriginalLevel()~=e:GetLabel() then
		local lv=0
		if tc:GetOriginalLevel()>e:GetLabel() then lv=tc:GetOriginalLevel()-e:GetLabel()
		else lv=e:GetLabel()-tc:GetOriginalLevel() end
		Duel.SetLP(tp,Duel.GetLP(tp)-lv*1000)
	end
end
