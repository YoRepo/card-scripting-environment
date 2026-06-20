--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 死亡青蛙  (ID: 84451804)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 5
-- ATK 1900 | DEF 0
-- Setcode: 18
--
-- Effect Text:
-- 这张卡的祭品召唤成功时，可以把最多有自己墓地存在的「恶魂邪苦止」数量的「死亡青蛙」从手卡或者卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--デスガエル
function c84451804.initial_effect(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(84451804,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c84451804.condition)
	e1:SetTarget(c84451804.target)
	e1:SetOperation(c84451804.operation)
	c:RegisterEffect(e1)
end
function c84451804.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_ADVANCE)
end
function c84451804.filter(c,e,tp)
	return c:IsCode(84451804) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c84451804.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,10456559)
		and Duel.IsExistingMatchingCard(c84451804.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c84451804.operation(e,tp,eg,ep,ev,re,r,rp)
	local ct=math.min((Duel.GetLocationCount(tp,LOCATION_MZONE)),Duel.GetMatchingGroupCount(Card.IsCode,tp,LOCATION_GRAVE,0,nil,10456559))
	if ct<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ct=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c84451804.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,ct,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
