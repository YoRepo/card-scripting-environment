--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Naturia Cosmobeet  (ID: 98437424)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Plant
-- Level: 2
-- ATK 1000 | DEF 700
-- Setcode: 0x2a
-- Scope: OCG / TCG
--
-- Effect Text:
-- When your opponent Normal Summons/Sets a monster: You can Special Summon this card from your hand.
--[[ __CARD_HEADER_END__ ]]

--ナチュル・コスモスビート
function c98437424.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98437424,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c98437424.spcon)
	e1:SetTarget(c98437424.sptg)
	e1:SetOperation(c98437424.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_MSET)
	c:RegisterEffect(e2)
end
function c98437424.spcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c98437424.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c98437424.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
