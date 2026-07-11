--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Worm Ugly  (ID: 76683171)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Reptile
-- Level: 1
-- ATK 100 | DEF 100
-- Setcode: 0x3e
-- Scope: OCG / TCG
--
-- Effect Text:
-- When you Tribute Summon a Reptile-Type "Worm" monster by Tributing this card, you can Special Summon
-- this card from your Graveyard to your opponent's side of the field, in face-up Attack Position.
--[[ __CARD_HEADER_END__ ]]

--ワーム・アグリィ
function c76683171.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(76683171,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCondition(c76683171.spcon)
	e1:SetTarget(c76683171.sptg)
	e1:SetOperation(c76683171.spop)
	c:RegisterEffect(e1)
end
function c76683171.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and r==REASON_SUMMON and c:GetReasonCard():IsSetCard(0x3e)
end
function c76683171.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK,1-tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c76683171.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,1-tp,false,false,POS_FACEUP_ATTACK)
	end
end
