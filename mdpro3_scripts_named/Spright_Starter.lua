--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 卫星闪灵启辉器  (ID: 15443125)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 384
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从卡组把1只「卫星闪灵」怪兽特殊召唤，自己失去那只怪兽的原本攻击力数值的基本分。这张卡的发动后，直到回合结束时自己不是2星·2阶·连接2的怪兽不能特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--スプライト・スターター
function c15443125.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,15443125+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c15443125.target)
	e1:SetOperation(c15443125.activate)
	c:RegisterEffect(e1)
end
function c15443125.filter(c,e,tp)
	return c:IsSetCard(0x180) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c15443125.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c15443125.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c15443125.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c15443125.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0 then
		local lp=Duel.GetLP(tp)
		Duel.SetLP(tp,lp-tc:GetBaseAttack())
	end
	if not e:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c15443125.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c15443125.splimit(e,c)
	return not c:IsLevel(2) and not c:IsRank(2) and not c:IsLink(2)
end
