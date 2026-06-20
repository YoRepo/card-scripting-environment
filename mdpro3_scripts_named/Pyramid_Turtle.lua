--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 金字塔龟  (ID: 77044671)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Zombie
-- Level 4
-- ATK 1200 | DEF 1400
--
-- Effect Text:
-- ①：这张卡被战斗破坏送去墓地时才能发动。从卡组把1只守备力2000以下的不死族怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ピラミッド・タートル
function c77044671.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(77044671,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c77044671.condition)
	e1:SetTarget(c77044671.target)
	e1:SetOperation(c77044671.operation)
	c:RegisterEffect(e1)
end
function c77044671.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c77044671.filter(c,e,tp)
	return c:IsDefenseBelow(2000) and c:IsRace(RACE_ZOMBIE)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c77044671.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c77044671.filter,tp,LOCATION_DECK,0,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c77044671.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c77044671.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
