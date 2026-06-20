--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 突击枪犬  (ID: 72714226)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 4
-- ATK 1200 | DEF 800
--
-- Effect Text:
-- ①：这张卡被战斗破坏送去墓地时才能发动。从卡组把「突击枪犬」任意数量特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--アサルト・ガンドッグ
function c72714226.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(72714226,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c72714226.condition)
	e1:SetTarget(c72714226.target)
	e1:SetOperation(c72714226.operation)
	c:RegisterEffect(e1)
end
function c72714226.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c72714226.filter(c,e,tp)
	return c:IsCode(72714226) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c72714226.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c72714226.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c72714226.operation(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ct<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ct=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c72714226.filter,tp,LOCATION_DECK,0,1,ct,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
