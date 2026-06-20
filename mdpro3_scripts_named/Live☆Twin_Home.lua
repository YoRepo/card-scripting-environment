--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 直播☆双子入口页  (ID: 8083925)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 4433
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：丢弃1张手卡才能发动。从卡组把1只「姬丝基勒」怪兽或「璃拉」怪兽特殊召唤。这张卡的发动后，直到回合结束时自己不是「邪恶★双子」怪兽不能从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--Live☆Twin エントランス
function c8083925.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(8083925,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCountLimit(1,8083925+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c8083925.cost)
	e1:SetTarget(c8083925.target)
	e1:SetOperation(c8083925.activate)
	c:RegisterEffect(e1)
end
function c8083925.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c8083925.filter(c,e,tp)
	return c:IsSetCard(0x152,0x153) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c8083925.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c8083925.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c8083925.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c8083925.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
	if not e:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c8083925.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c8083925.splimit(e,c)
	return not c:IsSetCard(0x2151) and c:IsLocation(LOCATION_EXTRA)
end
