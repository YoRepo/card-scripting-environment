--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 精神脑魔  (ID: 96782886)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Psychic
-- Level 1
-- ATK 100 | DEF 200
--
-- Effect Text:
-- 支付800基本分，把自己场上「精神脑魔」以外的1只念动力族怪兽解放发动。从自己的卡组把1只等级4以下的念动力族怪兽在自己场上以表侧攻击表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--メンタルマスター
function c96782886.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(96782886,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c96782886.cost)
	e1:SetTarget(c96782886.target)
	e1:SetOperation(c96782886.operation)
	c:RegisterEffect(e1)
end
function c96782886.costfilter(c,ft,tp)
	return c:IsRace(RACE_PSYCHO) and not c:IsCode(96782886)
		and (ft>0 or (c:IsControler(tp) and c:GetSequence()<5)) and (c:IsControler(tp) or c:IsFaceup())
end
function c96782886.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return Duel.CheckLPCost(tp,800)
		and ft>-1 and Duel.CheckReleaseGroup(tp,c96782886.costfilter,1,nil,ft,tp) end
	Duel.PayLPCost(tp,800)
	local sg=Duel.SelectReleaseGroup(tp,c96782886.costfilter,1,1,nil,ft,tp)
	Duel.Release(sg,REASON_COST)
end
function c96782886.filter(c,e,tp)
	return c:IsRace(RACE_PSYCHO) and c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK)
end
function c96782886.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c96782886.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c96782886.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c96782886.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_ATTACK) end
end
