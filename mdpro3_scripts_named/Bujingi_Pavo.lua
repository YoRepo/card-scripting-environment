--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 武神器-五百箇  (ID: 10860121)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Winged Beast
-- Level 4
-- ATK 1700 | DEF 800
-- Setcode: 136
--
-- Effect Text:
-- 「武神器-五百箇」的效果1回合只能使用1次。
-- ①：自己场上的兽战士族「武神」怪兽被战斗破坏送去墓地时，把这张卡从手卡送去墓地才能发动。从卡组把1只「武神」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--武神器－イオツミ
function c10860121.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10860121,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,10860121)
	e1:SetCondition(c10860121.condition)
	e1:SetCost(c10860121.cost)
	e1:SetTarget(c10860121.target)
	e1:SetOperation(c10860121.operation)
	c:RegisterEffect(e1)
end
function c10860121.cfilter(c,tp)
	return c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
		and c:IsSetCard(0x88) and c:IsRace(RACE_BEASTWARRIOR) and c:IsReason(REASON_BATTLE)
end
function c10860121.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c10860121.cfilter,1,nil,tp)
end
function c10860121.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c10860121.filter(c,e,tp)
	return c:IsSetCard(0x88) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c10860121.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c10860121.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_DECK)
end
function c10860121.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c10860121.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
