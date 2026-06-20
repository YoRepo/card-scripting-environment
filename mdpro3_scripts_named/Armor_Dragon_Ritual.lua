--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 铠龙降临  (ID: 58827995)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「铠龙之圣骑士」的降临必需。这个卡名的②的效果1回合只能使用1次。
-- ①：等级合计直到4以上的自己的手卡·场上的怪兽解放，从手卡把「铠龙之圣骑士」仪式召唤。
-- ②：从手卡以及自己场上的表侧表示怪兽之中把等级合计直到4以上的怪兽除外才能发动。墓地的这张卡除外，从自己墓地选1只「铠龙之圣骑士」特殊召唤。这个效果在这张卡送去墓地的回合不能发动。
--[[ __CARD_HEADER_END__ ]]

--鎧竜降臨
function c58827995.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,75901113)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,58827995)
	e1:SetCondition(aux.exccon)
	e1:SetCost(c58827995.spcost)
	e1:SetTarget(c58827995.sptg)
	e1:SetOperation(c58827995.spop)
	c:RegisterEffect(e1)
end
function c58827995.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost() and c:IsLevelAbove(1) and (c:IsLocation(LOCATION_HAND) or c:IsFaceup())
end
function c58827995.fselect(g,tp)
	Duel.SetSelectedCard(g)
	return g:CheckWithSumGreater(Card.GetLevel,4) and aux.mzctcheck(g,tp)
end
function c58827995.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetFieldGroup(tp,LOCATION_MZONE+LOCATION_HAND,0)
	local sg=g:Filter(c58827995.cfilter,nil)
	if chk==0 then return sg:CheckSubGroup(c58827995.fselect,1,sg:GetCount(),tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg=sg:SelectSubGroup(tp,c58827995.fselect,false,1,sg:GetCount(),tp)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c58827995.spfilter(c,e,tp)
	return c:IsCode(75901113) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c58827995.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and Duel.IsExistingMatchingCard(c58827995.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c58827995.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.Remove(c,POS_FACEUP,REASON_EFFECT)~=0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c58827995.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
