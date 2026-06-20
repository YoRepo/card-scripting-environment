--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 薰风的希望 神威  (ID: 72439556)
-- Type: Monster / Effect / Toon
-- Attribute: WIND
-- Race: Psychic
-- Level 2
-- ATK 200 | DEF 1000
-- Setcode: 16
--
-- Effect Text:
-- 反转：从自己卡组把1只名字带有「薰风」的调整特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ガスタの希望 カムイ
function c72439556.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(72439556,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c72439556.target)
	e1:SetOperation(c72439556.operation)
	c:RegisterEffect(e1)
end
function c72439556.filter(c,e,tp)
	return c:IsSetCard(0x10) and c:IsType(TYPE_TUNER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c72439556.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c72439556.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c72439556.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
