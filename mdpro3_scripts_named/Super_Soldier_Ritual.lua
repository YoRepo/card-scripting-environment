--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 超战士的仪式  (ID: 14094090)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「混沌战士」仪式怪兽的降临必需。「超战士的仪式」的②的效果1回合只能使用1次。
-- ①：从自己的手卡·场上把等级合计直到8的怪兽解放，从手卡把1只「混沌战士」仪式怪兽仪式召唤。
-- ②：从自己墓地把这张卡以及1只光属性怪兽和1只暗属性怪兽除外才能发动。从手卡把1只「混沌战士」仪式怪兽无视召唤条件特殊召唤。这个效果在这张卡送去墓地的回合不能发动。
--[[ __CARD_HEADER_END__ ]]

--超戦士の儀式
function c14094090.initial_effect(c)
	aux.AddRitualProcEqual(c,c14094090.ritual_filter)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,14094090)
	e1:SetCondition(aux.exccon)
	e1:SetCost(c14094090.spcost)
	e1:SetTarget(c14094090.sptg)
	e1:SetOperation(c14094090.spop)
	c:RegisterEffect(e1)
end
function c14094090.ritual_filter(c)
	return c:IsType(TYPE_RITUAL) and c:IsSetCard(0x10cf)
end
function c14094090.cfilter(c,att)
	return c:IsAttribute(att) and c:IsAbleToRemoveAsCost()
end
function c14094090.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c14094090.cfilter,tp,LOCATION_GRAVE,0,1,nil,ATTRIBUTE_LIGHT)
		and Duel.IsExistingMatchingCard(c14094090.cfilter,tp,LOCATION_GRAVE,0,1,nil,ATTRIBUTE_DARK) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c14094090.cfilter,tp,LOCATION_GRAVE,0,1,1,nil,ATTRIBUTE_LIGHT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,c14094090.cfilter,tp,LOCATION_GRAVE,0,1,1,nil,ATTRIBUTE_DARK)
	g1:Merge(g2)
	g1:AddCard(e:GetHandler())
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
function c14094090.spfilter(c,e,tp)
	return c:IsSetCard(0x10cf) and c:IsType(TYPE_RITUAL) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c14094090.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c14094090.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c14094090.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c14094090.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end
