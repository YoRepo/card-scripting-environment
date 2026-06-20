--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 复仇死者的突击  (ID: 76798740)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 262
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从手卡以及自己场上的表侧表示怪兽之中把1只不死族怪兽送去墓地才能发动。从卡组把1只「复仇死者」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ヴェンデット・チャージ
function c76798740.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,76798740+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c76798740.cost)
	e1:SetTarget(c76798740.target)
	e1:SetOperation(c76798740.activate)
	c:RegisterEffect(e1)
end
function c76798740.cfilter(c,tp)
	return c:IsRace(RACE_ZOMBIE) and (c:IsFaceup() or c:IsLocation(LOCATION_HAND)) and c:IsAbleToGraveAsCost()
		and Duel.GetMZoneCount(tp,c)>0
end
function c76798740.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c76798740.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c76798740.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil,tp)
	Duel.SendtoGrave(g,REASON_COST)
end
function c76798740.filter(c,e,tp)
	return c:IsSetCard(0x106) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c76798740.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c76798740.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c76798740.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c76798740.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
