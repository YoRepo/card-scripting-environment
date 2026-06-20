--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 堕天使的戒坛  (ID: 14517422)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 239
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从自己墓地把1只「堕天使」怪兽守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--堕天使の戒壇
function c14517422.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,14517422+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c14517422.sptg)
	e1:SetOperation(c14517422.spop)
	c:RegisterEffect(e1)
end
function c14517422.filter(c,e,tp)
	return c:IsSetCard(0xef) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c14517422.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c14517422.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c14517422.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c14517422.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
