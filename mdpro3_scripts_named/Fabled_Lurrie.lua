--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Fabled Lurrie  (ID: 97651498)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fiend
-- Level: 1
-- ATK 200 | DEF 400
-- Setcode: 0x35
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is discarded to the GY: Special Summon it.
--[[ __CARD_HEADER_END__ ]]

--魔轟神ルリー
function c97651498.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(97651498,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c97651498.spcon)
	e1:SetTarget(c97651498.sptg)
	e1:SetOperation(c97651498.spop)
	c:RegisterEffect(e1)
end
function c97651498.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND) and bit.band(r,REASON_DISCARD)~=0
end
function c97651498.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c97651498.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
