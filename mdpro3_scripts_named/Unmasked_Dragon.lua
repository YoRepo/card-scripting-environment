--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 破面龙  (ID: 24218047)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Wyrm
-- Level 3
-- ATK 1400 | DEF 1100
--
-- Effect Text:
-- ①：这张卡被战斗破坏送去墓地时才能发动。从卡组把1只守备力1500以下的幻龙族怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--破面竜
function c24218047.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(24218047,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c24218047.condition)
	e1:SetTarget(c24218047.target)
	e1:SetOperation(c24218047.operation)
	c:RegisterEffect(e1)
end
function c24218047.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c24218047.filter(c,e,tp)
	return c:IsDefenseBelow(1500) and c:IsRace(RACE_WYRM)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c24218047.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c24218047.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c24218047.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c24218047.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
