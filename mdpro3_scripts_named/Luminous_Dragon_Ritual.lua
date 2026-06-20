--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 光子龙降临  (ID: 34834619)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「光子龙之圣骑士」的降临必需。必须从自己的手卡·场上把等级合计直到4的怪兽解放。此外，自己的主要阶段时把墓地的这张卡从游戏中除外才能发动。等级合计直到4的自己墓地的怪兽从游戏中除外，从手卡把1只「光子
-- 龙之圣骑士」当作仪式召唤作特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--光子竜降臨
function c34834619.initial_effect(c)
	aux.AddRitualProcEqualCode(c,85346853)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(34834619,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c34834619.sptg)
	e1:SetOperation(c34834619.spop)
	c:RegisterEffect(e1)
end
function c34834619.mtfilter(c,e)
	return c:GetLevel()>0 and c:IsAbleToRemove() and not c:IsImmuneToEffect(e)
end
function c34834619.spfilter(c,e,tp,m)
	return c:IsCode(85346853) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,false)
		and m:CheckWithSumEqual(Card.GetRitualLevel,4,1,99,c)
end
function c34834619.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		local mg=Duel.GetMatchingGroup(c34834619.mtfilter,tp,LOCATION_GRAVE,0,e:GetHandler(),e)
		return Duel.IsExistingMatchingCard(c34834619.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp,mg)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c34834619.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local mg=Duel.GetMatchingGroup(c34834619.mtfilter,tp,LOCATION_GRAVE,0,nil,e)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c34834619.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp,mg)
	local tc=g:GetFirst()
	if tc then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local mat=mg:SelectWithSumEqual(tp,Card.GetRitualLevel,4,1,99,tc)
		tc:SetMaterial(mat)
		Duel.ReleaseRitualMaterial(mat)
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,true,false,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
