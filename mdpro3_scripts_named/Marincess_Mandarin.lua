--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Marincess Mandarin  (ID: 28174796)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Cyberse
-- Level: 1
-- ATK 100 | DEF 100
-- Setcode: 0x12b
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control 2 or more "Marincess" monsters, while this card is in your hand or GY: You can target
-- 1 WATER Link Monster you control; Special Summon this card to your zone that monster points to, but
-- banish it when it leaves the field.
-- You can only use this effect of "Marincess Mandarin" once per turn.
--[[ __CARD_HEADER_END__ ]]

--海晶乙女マンダリン
function c28174796.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(28174796,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCountLimit(1,28174796)
	e1:SetCondition(c28174796.spcon)
	e1:SetTarget(c28174796.sptg)
	e1:SetOperation(c28174796.spop)
	c:RegisterEffect(e1)
end
function c28174796.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x12b)
end
function c28174796.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c28174796.cfilter,tp,LOCATION_MZONE,0,2,nil)
end
function c28174796.spfilter(c,e,tp,ec)
	local zone=c:GetLinkedZone(tp)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER) and c:IsType(TYPE_LINK) and ec:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp,zone)
end
function c28174796.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c28174796.spfilter(chkc,e,tp,c) end
	if chk==0 then return Duel.IsExistingTarget(c28174796.spfilter,tp,LOCATION_MZONE,0,1,nil,e,tp,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c28174796.spfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp,c)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c28174796.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local zone=tc:GetLinkedZone(tp)
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and zone&0x1f~=0
		and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP,zone)>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e1,true)
	end
end
