--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Predaplant Heliamphorhynchus  (ID: 5259518)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Plant
-- Level: 8
-- ATK 1200 | DEF 2400
-- Setcode: 0x10f3
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your opponent controls a monster with a Predator Counter: You can Special Summon this card from
-- your hand.
-- If this card in its owner's possession is destroyed by your opponent's card: You can target 1 DARK
-- Dragon or 1 DARK Plant monster in your GY, except "Predaplant Heliamphorhynchus"; Special Summon it.
-- You can only use each effect of "Predaplant Heliamphorhynchus" once per turn.
--[[ __CARD_HEADER_END__ ]]

--捕食植物ヘリアンフォリンクス
function c5259518.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,5259518)
	e1:SetCondition(c5259518.spcon1)
	e1:SetTarget(c5259518.sptg1)
	e1:SetOperation(c5259518.spop1)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCountLimit(1,5259519)
	e2:SetCondition(c5259518.spcon2)
	e2:SetTarget(c5259518.sptg2)
	e2:SetOperation(c5259518.spop2)
	c:RegisterEffect(e2)
end
function c5259518.cfilter(c)
	return c:IsFaceup() and c:GetCounter(0x1041)>0
end
function c5259518.spcon1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c5259518.cfilter,tp,0,LOCATION_MZONE,1,nil)
end
function c5259518.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c5259518.spop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c5259518.spcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return (c:IsReason(REASON_BATTLE) or rp==1-tp) and c:IsPreviousControler(tp)
end
function c5259518.spfilter(c,e,tp)
	return c:IsRace(RACE_DRAGON+RACE_PLANT) and c:IsAttribute(ATTRIBUTE_DARK) and not c:IsCode(5259518) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c5259518.sptg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c5259518.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c5259518.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c5259518.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c5259518.spop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
