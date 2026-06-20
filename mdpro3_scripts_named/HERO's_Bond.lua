--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 英雄联合  (ID: 76442616)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 8
--
-- Effect Text:
-- 场上有名字带有「英雄」的怪兽存在时才能发动。从手卡特殊召唤2只4星以下的名字带有「元素英雄」的怪兽。
--[[ __CARD_HEADER_END__ ]]

--HERO’S ボンド
function c76442616.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c76442616.condition)
	e1:SetTarget(c76442616.target)
	e1:SetOperation(c76442616.activate)
	c:RegisterEffect(e1)
end
function c76442616.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x8)
end
function c76442616.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c76442616.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c76442616.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsSetCard(0x3008) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c76442616.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsExistingMatchingCard(c76442616.filter,tp,LOCATION_HAND,0,2,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_HAND)
end
function c76442616.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
	local g=Duel.GetMatchingGroup(c76442616.filter,tp,LOCATION_HAND,0,nil,e,tp)
	if g:GetCount()>=2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,2,2,nil)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
