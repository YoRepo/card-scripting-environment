--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Superheavy Samurai Drum  (ID: 87535691)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Machine
-- Level: 1
-- ATK 300 | DEF 300
-- Setcode: 0x9a
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card on the field is destroyed and sent to the Graveyard: You can target 1 "Superheavy
-- Samurai" monster in your Graveyard, except "Superheavy Samurai Drum"; Special Summon it.
-- You can only use this effect of "Superheavy Samurai Drum" once per turn.
--[[ __CARD_HEADER_END__ ]]

--超重武者ツヅ－3
function c87535691.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(87535691,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,87535691)
	e1:SetCondition(c87535691.spcon)
	e1:SetTarget(c87535691.sptg)
	e1:SetOperation(c87535691.spop)
	c:RegisterEffect(e1)
end
function c87535691.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD) and e:GetHandler():IsReason(REASON_DESTROY)
end
function c87535691.spfilter(c,e,tp)
	return c:IsSetCard(0x9a) and not c:IsCode(87535691) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c87535691.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c87535691.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c87535691.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c87535691.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c87535691.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
