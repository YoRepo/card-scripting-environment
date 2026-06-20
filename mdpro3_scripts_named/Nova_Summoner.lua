--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 神召新星  (ID: 48783998)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 4
-- ATK 1400 | DEF 800
--
-- Effect Text:
-- ①：这张卡被战斗破坏送去墓地时才能发动。从卡组把1只攻击力1500以下的天使族·光属性怪兽特殊召唤。场上有「天空的圣域」存在的场合，可以作为代替把1只「天空骑士 珀耳修斯」特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--コーリング・ノヴァ
function c48783998.initial_effect(c)
	aux.AddCodeList(c,56433456)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(48783998,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c48783998.condition)
	e1:SetTarget(c48783998.target)
	e1:SetOperation(c48783998.operation)
	c:RegisterEffect(e1)
end
function c48783998.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c48783998.filter1(c,e,tp)
	return c:IsAttackBelow(1500) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_FAIRY)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c48783998.filter2(c,e,tp)
	return (c:IsCode(18036057) or (c:IsAttackBelow(1500) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_FAIRY)))
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c48783998.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		if not Duel.IsEnvironment(56433456) then
			return Duel.IsExistingMatchingCard(c48783998.filter1,tp,LOCATION_DECK,0,1,nil,e,tp)
		else
			return Duel.IsExistingMatchingCard(c48783998.filter2,tp,LOCATION_DECK,0,1,nil,e,tp)
		end
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c48783998.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local g=nil
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	if not Duel.IsEnvironment(56433456) then
		g=Duel.SelectMatchingCard(tp,c48783998.filter1,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	else
		g=Duel.SelectMatchingCard(tp,c48783998.filter2,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	end
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
