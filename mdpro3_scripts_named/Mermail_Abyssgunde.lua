--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 水精鳞-深渊昆德  (ID: 69293721)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 3
-- ATK 1400 | DEF 800
-- Setcode: 7667828
--
-- Effect Text:
-- 这张卡从手卡丢弃去墓地的场合，可以从自己墓地选择「水精鳞-深渊昆德」以外的1只名字带有「水精鳞」的怪兽特殊召唤。「水精鳞-深渊昆德」的效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--水精鱗－アビスグンデ
function c69293721.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(69293721,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,69293721)
	e1:SetCondition(c69293721.condition)
	e1:SetTarget(c69293721.target)
	e1:SetOperation(c69293721.operation)
	c:RegisterEffect(e1)
end
function c69293721.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DISCARD) and e:GetHandler():IsPreviousLocation(LOCATION_HAND)
end
function c69293721.filter(c,e,tp)
	return c:IsSetCard(0x74) and not c:IsCode(69293721) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c69293721.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c69293721.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c69293721.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c69293721.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c69293721.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
