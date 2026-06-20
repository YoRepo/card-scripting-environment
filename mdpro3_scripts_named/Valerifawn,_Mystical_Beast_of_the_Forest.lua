--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 森之圣兽 缬草小鹿  (ID: 24096499)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Beast
-- Level 2
-- ATK 400 | DEF 900
-- Setcode: 4455
--
-- Effect Text:
-- 「森之圣兽 缬草小鹿」的效果1回合只能使用1次。
-- ①：丢弃1张手卡，以「森之圣兽 缬草小鹿」以外的自己墓地1只2星以下的兽族怪兽为对象才能发动。那只怪兽表侧攻击表示或者里侧守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--森の聖獣 ヴァレリフォーン
function c24096499.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(24096499,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,24096499)
	e1:SetCost(c24096499.spcost)
	e1:SetTarget(c24096499.sptg)
	e1:SetOperation(c24096499.spop)
	c:RegisterEffect(e1)
end
function c24096499.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c24096499.filter(c,e,tp)
	return c:IsLevelBelow(2) and c:IsRace(RACE_BEAST) and not c:IsCode(24096499) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK+POS_FACEDOWN_DEFENSE)
end
function c24096499.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c24096499.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c24096499.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c24096499.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c24096499.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK+POS_FACEDOWN_DEFENSE)>0
		and tc:IsFacedown() then
		Duel.ConfirmCards(1-tp,tc)
	end
end
