--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 天法院  (ID: 24449083)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：自己主要阶段才能发动。从手卡把1只天使族怪兽特殊召唤。这个效果在自己场上有1星天使族怪兽存在的场合才能发动和处理。
--[[ __CARD_HEADER_END__ ]]

--コート・オブ・ジャスティス
function c24449083.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(24449083,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,24449083)
	e2:SetCondition(c24449083.condition)
	e2:SetTarget(c24449083.target)
	e2:SetOperation(c24449083.operation)
	c:RegisterEffect(e2)
end
function c24449083.cfilter(c)
	return c:IsFaceup() and c:IsLevel(1) and c:IsRace(RACE_FAIRY)
end
function c24449083.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c24449083.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c24449083.filter(c,e,sp)
	return c:IsRace(RACE_FAIRY) and c:IsCanBeSpecialSummoned(e,0,sp,false,false)
end
function c24449083.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c24449083.filter,tp,LOCATION_HAND,0,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c24449083.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsExistingMatchingCard(c24449083.cfilter,tp,LOCATION_MZONE,0,1,nil) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c24449083.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
