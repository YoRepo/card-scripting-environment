--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 守墓的神职  (ID: 21663205)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 3
-- ATK 500 | DEF 1500
-- Setcode: 46
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡召唤·反转召唤·特殊召唤成功的场合，以自己墓地1只4星「守墓」怪兽为对象才能发动。那只怪兽表侧攻击表示或者里侧守备表示特殊召唤。这个效果不受「王家长眠之谷」的效果影响。
--[[ __CARD_HEADER_END__ ]]

--墓守の神職
function c21663205.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21663205,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,21663205)
	e1:SetTarget(c21663205.sptg)
	e1:SetOperation(c21663205.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--immune to necro valley
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_NECRO_VALLEY_IM)
	c:RegisterEffect(e4)
end
function c21663205.filter(c,e,tp)
	return c:IsLevel(4) and c:IsSetCard(0x2e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK+POS_FACEDOWN_DEFENSE)
end
function c21663205.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c21663205.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c21663205.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c21663205.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c21663205.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK+POS_FACEDOWN_DEFENSE)>0
		and tc:IsFacedown() then
		Duel.ConfirmCards(1-tp,tc)
	end
end
