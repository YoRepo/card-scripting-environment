--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 成金忍者  (ID: 58911105)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 4
-- ATK 500 | DEF 1800
-- Setcode: 43
--
-- Effect Text:
-- 1回合1次，从手卡把1张陷阱卡送去墓地才能发动。从卡组把1只4星以下的名字带有「忍者」的怪兽表侧守备表示或者里侧守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--成金忍者
function c58911105.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(58911105,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c58911105.cost)
	e1:SetTarget(c58911105.target)
	e1:SetOperation(c58911105.operation)
	c:RegisterEffect(e1)
end
function c58911105.costfilter(c)
	return c:IsType(TYPE_TRAP) and c:IsAbleToGraveAsCost()
end
function c58911105.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c58911105.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local cg=Duel.SelectMatchingCard(tp,c58911105.costfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(cg,REASON_COST)
end
function c58911105.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsSetCard(0x2b) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_DEFENSE)
end
function c58911105.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c58911105.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c58911105.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c58911105.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if not tc then return end
	if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_DEFENSE)~=0 and tc:IsFacedown() then
		Duel.ConfirmCards(1-tp,tc)
	end
end
