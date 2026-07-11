--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Naturia Pineapple  (ID: 7304544)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level: 2
-- ATK 100 | DEF 100
-- Setcode: 0x2a
-- Scope: OCG / TCG
--
-- Effect Text:
-- All face-up monsters you control become Plant monsters.
-- Once per turn, during your Standby Phase, if you do not control a face-up "Naturia Pineapple", and
-- have no monsters in your GY except Plant or Beast: You can Special Summon this card from your GY.
-- You must control no Spells or Traps to activate and resolve this effect.
--[[ __CARD_HEADER_END__ ]]

--ナチュル・パイナポー
function c7304544.initial_effect(c)
	--Change race
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_RACE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetValue(RACE_PLANT)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(7304544,0))
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1)
	e2:SetCondition(c7304544.condition)
	e2:SetTarget(c7304544.target)
	e2:SetOperation(c7304544.operation)
	c:RegisterEffect(e2)
end
function c7304544.filter(c)
	return c:IsCode(7304544) and c:IsFaceup()
end
function c7304544.filter2(c)
	return c:IsType(TYPE_MONSTER) and not c:IsRace(RACE_PLANT+RACE_BEAST)
end
function c7304544.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and not Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_ONFIELD,0,1,nil,TYPE_SPELL+TYPE_TRAP)
		and not Duel.IsExistingMatchingCard(c7304544.filter,tp,LOCATION_ONFIELD,0,1,nil)
		and not Duel.IsExistingMatchingCard(c7304544.filter2,tp,LOCATION_GRAVE,0,1,nil)
end
function c7304544.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c7304544.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e)
		and not Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_ONFIELD,0,1,nil,TYPE_SPELL+TYPE_TRAP) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
