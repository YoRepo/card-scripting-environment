--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 进化虫·西洛仙蜥  (ID: 81873903)
-- Type: Monster / Effect / Toon
-- Attribute: FIRE
-- Race: Reptile
-- Level 3
-- ATK 700 | DEF 1900
-- Setcode: 12366
--
-- Effect Text:
-- 反转：从自己卡组把1只名字带有「进化龙」的怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--エヴォルド・ウェストロ
function c81873903.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(81873903,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FLIP+EFFECT_TYPE_SINGLE)
	e1:SetTarget(c81873903.target)
	e1:SetOperation(c81873903.operation)
	c:RegisterEffect(e1)
end
function c81873903.filter(c,e,tp)
	return c:IsSetCard(0x604e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c81873903.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c81873903.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c81873903.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
