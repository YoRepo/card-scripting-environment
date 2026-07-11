--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Horus the Black Flame Dragon LV6  (ID: 11224103)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Dragon
-- Level: 6
-- ATK 2300 | DEF 1600
-- Setcode: 0x41, 0x119d
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is unaffected by Spell effects.
-- During the End Phase, if this card destroyed a monster by battle this turn: You can send this
-- face-up card to the Graveyard; Special Summon 1 "Horus the Black Flame Dragon LV8" from your hand or
-- Deck.
--[[ __CARD_HEADER_END__ ]]

--ホルスの黒炎竜 LV6
function c11224103.initial_effect(c)
	--battle destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCondition(aux.bdcon)
	e1:SetOperation(c11224103.bdop)
	c:RegisterEffect(e1)
	--immune spell
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c11224103.efilter)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(11224103,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetCondition(c11224103.spcon)
	e3:SetCost(c11224103.spcost)
	e3:SetTarget(c11224103.sptg)
	e3:SetOperation(c11224103.spop)
	c:RegisterEffect(e3)
end
c11224103.lvup={48229808}
c11224103.lvdn={75830094}
function c11224103.bdop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(11224103,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
end
function c11224103.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL)
end
function c11224103.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(11224103)>0
end
function c11224103.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c11224103.spfilter(c,e,tp)
	return c:IsCode(48229808) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c11224103.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c11224103.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c11224103.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c11224103.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
