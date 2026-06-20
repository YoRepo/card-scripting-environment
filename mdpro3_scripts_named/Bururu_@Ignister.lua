--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 抖抖妖@火灵天星  (ID: 42429678)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Cyberse
-- Level 3
-- ATK 600 | DEF 1000
-- Setcode: 309
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡召唤·特殊召唤成功的场合才能发动。从卡组把1只「@火灵天星」怪兽送去墓地。
-- ②：这张卡作为电子界族同调怪兽的同调素材送去墓地的场合，以「抖抖妖@火灵天星」以外的自己墓地1只作为那次同调召唤的素材的怪兽为对象才能发动。那只怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ブルル＠イグニスター
function c42429678.initial_effect(c)
	--to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(42429678,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,42429678)
	e1:SetTarget(c42429678.tgtg)
	e1:SetOperation(c42429678.tgop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(42429678,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_BE_MATERIAL)
	e3:SetCountLimit(1,42429679)
	e3:SetCondition(c42429678.spcon)
	e3:SetTarget(c42429678.sptg)
	e3:SetOperation(c42429678.spop)
	c:RegisterEffect(e3)
end
function c42429678.tgfilter(c)
	return c:IsSetCard(0x135) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c42429678.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c42429678.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c42429678.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c42429678.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c42429678.spcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_SYNCHRO and e:GetHandler():GetReasonCard():IsRace(RACE_CYBERSE)
end
function c42429678.spfilter(c,e,tp)
	return c:IsLocation(LOCATION_GRAVE) and c:IsControler(tp) and not c:IsCode(42429678) and c:IsCanBeEffectTarget(e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c42429678.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local mg=e:GetHandler():GetReasonCard():GetMaterial()
	if chkc then return mg:IsContains(chkc) and c42429678.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and mg:IsExists(c42429678.spfilter,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=mg:FilterSelect(tp,c42429678.spfilter,1,1,nil,e,tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c42429678.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
