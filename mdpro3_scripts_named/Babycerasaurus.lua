--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 小角龙  (ID: 36042004)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dinosaur
-- Level 2
-- ATK 500 | DEF 500
--
-- Effect Text:
-- ①：这张卡被效果破坏送去墓地的场合发动。从卡组把1只4星以下的恐龙族怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ベビケラサウルス
function c36042004.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(36042004,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c36042004.condition)
	e1:SetTarget(c36042004.target)
	e1:SetOperation(c36042004.operation)
	c:RegisterEffect(e1)
end
function c36042004.condition(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,0x41)==0x41
end
function c36042004.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsRace(RACE_DINOSAUR)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c36042004.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c36042004.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c36042004.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
