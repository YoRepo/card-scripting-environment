--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 引导的圣女 奎姆  (ID: 45883110)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 4
-- ATK 1500 | DEF 1500
-- Setcode: 23331141
--
-- Effect Text:
-- 这个卡名在规则上也当作「教导」卡、「死狱乡」卡使用。这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡召唤·特殊召唤的场合才能发动。把1只「阿不思的落胤」或者1张有那个卡名记述的卡从卡组送去墓地。
-- ②：自己·对方的卡从额外卡组离开的场合，以除「引导的圣女 奎姆」外的自己墓地1只「阿不思的落胤」或者有那个卡名记述的怪兽为对象才能发动。那只怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--導きの聖女クエム
function c45883110.initial_effect(c)
	aux.AddCodeList(c,68468459)
	--to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(45883110,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,45883110)
	e1:SetTarget(c45883110.tgtg)
	e1:SetOperation(c45883110.tgop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(45883110,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_LEAVE_DECK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,45883111)
	e3:SetCondition(c45883110.spcon)
	e3:SetTarget(c45883110.sptg)
	e3:SetOperation(c45883110.spop)
	c:RegisterEffect(e3)
end
function c45883110.tgfilter(c)
	return aux.IsCodeOrListed(c,68468459) and c:IsAbleToGrave()
end
function c45883110.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c45883110.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c45883110.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c45883110.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c45883110.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsPreviousLocation,1,nil,LOCATION_EXTRA)
end
function c45883110.spfilter(c,e,tp)
	return aux.IsCodeOrListed(c,68468459) and not c:IsCode(45883110)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c45883110.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c45883110.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c45883110.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c45883110.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c45883110.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
