--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 毛兽攻击者  (ID: 21362970)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 4
-- ATK 1850 | DEF 400
--
-- Effect Text:
-- 丢弃1张手卡发动。从自己卡组把1只「毛扎」特殊召唤。这个效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--ビーストライカー
function c21362970.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21362970,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c21362970.spcost)
	e1:SetTarget(c21362970.sptg)
	e1:SetOperation(c21362970.spop)
	c:RegisterEffect(e1)
end
function c21362970.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c21362970.filter(c,e,tp)
	return c:IsCode(94878265) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c21362970.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c21362970.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c21362970.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c21362970.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
