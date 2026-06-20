--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 守墓之长  (ID: 62473983)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 5
-- ATK 1900 | DEF 1200
-- Setcode: 46
--
-- Effect Text:
-- 这张卡在自己场上只能存在1张。只要这张卡在场上存在，自己的墓地不受「王家长眠之谷」效果的影响。这张卡祭品召唤成功的场合，可以从自己的墓地中特殊召唤1张名称中带有「守墓」的怪兽卡上场。
--[[ __CARD_HEADER_END__ ]]

--墓守の長
function c62473983.initial_effect(c)
	c:SetUniqueOnField(1,0,62473983)
	--immune to necro valley
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_NECRO_VALLEY_IM)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(1,0)
	c:RegisterEffect(e1)
	--summon success
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(c62473983.spcon)
	e2:SetTarget(c62473983.sptg)
	e2:SetOperation(c62473983.spop)
	c:RegisterEffect(e2)
end
function c62473983.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_ADVANCE)
end
function c62473983.filter(c,e,tp)
	return c:IsSetCard(0x2e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c62473983.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c62473983.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c62473983.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c62473983.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c62473983.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
