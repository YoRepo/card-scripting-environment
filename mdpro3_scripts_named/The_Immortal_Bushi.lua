--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: The Immortal Bushi  (ID: 52035300)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level: 3
-- ATK 1200 | DEF 600
-- Scope: OCG / TCG
--
-- Effect Text:
-- While this card is face-up on the field, it cannot be Tributed, except for the Tribute Summon of a
-- Warrior monster.
-- Once per turn, during your Standby Phase, if this card is in your GY and all monsters in your GY are
-- Warrior: You can Special Summon this card.
-- You must control no monsters to activate and to resolve this effect.
--[[ __CARD_HEADER_END__ ]]

--不死武士
function c52035300.initial_effect(c)
	--release limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UNRELEASABLE_SUM)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c52035300.recon)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--Special Summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(52035300,0))
	e3:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1)
	e3:SetCondition(c52035300.condition)
	e3:SetTarget(c52035300.target)
	e3:SetOperation(c52035300.operation)
	c:RegisterEffect(e3)
end
function c52035300.recon(e,c)
	return not c:IsRace(RACE_WARRIOR)
end
function c52035300.filter(c)
	return c:IsType(TYPE_MONSTER) and not c:IsRace(RACE_WARRIOR)
end
function c52035300.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
		and not Duel.IsExistingMatchingCard(c52035300.filter,tp,LOCATION_GRAVE,0,1,nil)
end
function c52035300.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c52035300.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>0 then return end
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
