--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 自然樱桃  (ID: 60668166)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Plant
-- Level 1
-- ATK 200 | DEF 200
-- Setcode: 42
--
-- Effect Text:
-- 这张卡被对方从场上送去墓地的场合，可以从自己卡组把最多2只「自然樱桃」里侧守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ナチュル・チェリー
function c60668166.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(60668166,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c60668166.condition)
	e1:SetTarget(c60668166.target)
	e1:SetOperation(c60668166.operation)
	c:RegisterEffect(e1)
end
function c60668166.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return rp==1-tp and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c60668166.filter(c,e,tp)
	return c:IsCode(60668166) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE)
end
function c60668166.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c60668166.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c60668166.operation(e,tp,eg,ep,ev,re,r,rp)
	local ct=math.min((Duel.GetLocationCount(tp,LOCATION_MZONE)),2)
	if ct<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ct=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c60668166.filter,tp,LOCATION_DECK,0,1,ct,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)
		Duel.ConfirmCards(1-tp,g)
	end
end
