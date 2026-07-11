--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Mogmole  (ID: 9861795)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level: 2
-- ATK 800 | DEF 800
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card on the field is destroyed and sent to the Graveyard: You can Special Summon it from
-- your Graveyard in face-up Defense Position.
-- You can only use the effect of "Mogmole" once per Duel.
--[[ __CARD_HEADER_END__ ]]

--モグモール
function c9861795.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9861795,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,9861795+EFFECT_COUNT_CODE_DUEL)
	e1:SetCondition(c9861795.condition)
	e1:SetTarget(c9861795.target)
	e1:SetOperation(c9861795.operation)
	c:RegisterEffect(e1)
end
function c9861795.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c9861795.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c9861795.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
