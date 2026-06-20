--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 阿普卡提基尔  (ID: 41158734)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level 4
-- ATK 1800 | DEF 1200
--
-- Effect Text:
-- 自己场上有调整表侧表示存在的场合，场上表侧表示存在的这张卡的等级当作5星使用。场上存在的这张卡被破坏送去墓地时，可以选择自己墓地存在的1只「太阳之神官」特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--アポカテクイル
function c41158734.initial_effect(c)
	--level change
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CHANGE_LEVEL)
	e1:SetCondition(c41158734.lvcon)
	e1:SetValue(5)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetDescription(aux.Stringid(41158734,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c41158734.spcon)
	e2:SetTarget(c41158734.sptg)
	e2:SetOperation(c41158734.spop)
	c:RegisterEffect(e2)
end
function c41158734.lvfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_TUNER)
end
function c41158734.lvcon(e)
	return Duel.IsExistingMatchingCard(c41158734.lvfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c41158734.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD) and e:GetHandler():IsReason(REASON_DESTROY)
end
function c41158734.spfilter(c,e,tp)
	return c:IsCode(42280216) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c41158734.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c41158734.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c41158734.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c41158734.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c41158734.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
