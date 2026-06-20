--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 薰风隼  (ID: 46044841)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Winged Beast
-- Level 2
-- ATK 600 | DEF 1400
-- Setcode: 16
--
-- Effect Text:
-- 场上表侧表示存在的这张卡被战斗以外送去墓地时，可以从自己卡组把1只名字带有「薰风」的怪兽里侧守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ガスタ・ファルコ
function c46044841.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46044841,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c46044841.condition)
	e1:SetTarget(c46044841.target)
	e1:SetOperation(c46044841.operation)
	c:RegisterEffect(e1)
end
function c46044841.condition(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_BATTLE)==0 and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
		and e:GetHandler():IsPreviousPosition(POS_FACEUP)
end
function c46044841.filter(c,e,tp)
	return c:IsSetCard(0x10) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE)
end
function c46044841.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c46044841.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c46044841.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c46044841.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)
		Duel.ConfirmCards(1-tp,g)
	end
end
