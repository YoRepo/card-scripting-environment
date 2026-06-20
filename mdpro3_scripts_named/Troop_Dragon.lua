--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 军队龙  (ID: 55013285)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Dragon
-- Level 2
-- ATK 700 | DEF 800
--
-- Effect Text:
-- 这张卡被战斗破坏送去墓地的场合，从卡组选1张「军队龙」在自己的场上特殊召唤。之后卡组洗切。
--[[ __CARD_HEADER_END__ ]]

--軍隊竜
function c55013285.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(55013285,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c55013285.condition)
	e1:SetTarget(c55013285.target)
	e1:SetOperation(c55013285.operation)
	c:RegisterEffect(e1)
end
function c55013285.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c55013285.filter(c,e,tp)
	return c:IsCode(55013285) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c55013285.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c55013285.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c55013285.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c55013285.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
