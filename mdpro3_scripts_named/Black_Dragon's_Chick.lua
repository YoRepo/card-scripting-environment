--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 黑龙之雏  (ID: 36262024)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Dragon
-- Level 1
-- ATK 800 | DEF 500
--
-- Effect Text:
-- 把自己场上表侧表示存在的这张卡送去墓地才能发动。从手卡把1只「真红眼黑龙」特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--黒竜の雛
function c36262024.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(36262024,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c36262024.spcost)
	e1:SetTarget(c36262024.sptg)
	e1:SetOperation(c36262024.spop)
	c:RegisterEffect(e1)
end
function c36262024.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c36262024.filter(c,e,tp)
	return c:IsCode(74677422) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c36262024.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c36262024.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c36262024.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c36262024.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
