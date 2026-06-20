--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 暗道化师 彼得  (ID: 52624755)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 3
-- ATK 500 | DEF 1200
--
-- Effect Text:
-- ①：这张卡被送去墓地时，把墓地的这张卡除外才能发动。从手卡·卡组把1只「暗道化师 彼得」特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--闇・道化師のペーテン
function c52624755.initial_effect(c)
	--sp summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(52624755,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCost(c52624755.cost)
	e1:SetTarget(c52624755.target)
	e1:SetOperation(c52624755.operation)
	c:RegisterEffect(e1)
end
function c52624755.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c52624755.filter(c,e,sp)
	return c:IsCode(52624755) and c:IsCanBeSpecialSummoned(e,0,sp,false,false)
end
function c52624755.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c52624755.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c52624755.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c52624755.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
