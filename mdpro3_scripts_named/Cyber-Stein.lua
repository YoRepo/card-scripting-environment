--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 恶魔科学怪人  (ID: 69015963)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 2
-- ATK 700 | DEF 500
--
-- Effect Text:
-- ①：支付5000基本分才能发动。从额外卡组把1只融合怪兽攻击表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--デビル・フランケン
function c69015963.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetDescription(aux.Stringid(69015963,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c69015963.cost)
	e1:SetTarget(c69015963.target)
	e1:SetOperation(c69015963.operation)
	c:RegisterEffect(e1)
end
function c69015963.filter(c,e,tp)
	return c:IsType(TYPE_FUSION) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function c69015963.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,5000) end
	Duel.PayLPCost(tp,5000)
end
function c69015963.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c69015963.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c69015963.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c69015963.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end
end
