--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Conductor of Nephthys  (ID: 8454126)
-- Type: Monster / Effect / Ritual
-- Attribute: WIND
-- Race: Spellcaster
-- Level: 2
-- ATK 2000 | DEF 0
-- Setcode: 0x11f
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Ritual Summon this card with "Rebirth of Nephthys".
-- If this card is Ritual Summoned: You can Special Summon 1 "Nephthys" Ritual Monster from your hand
-- or Deck, except "Conductor of Nephthys" (this is treated as a Ritual Summon).
-- If this card is Tributed or destroyed by a "Nephthys" card effect: You can activate this effect;
-- during the next Standby Phase, destroy up to 3 "Nephthys" cards, except Ritual Monsters, 1 each from
-- your hand, Deck, and field.
-- You can only use each effect of "Conductor of Nephthys" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ネフティスの繋ぎ手
function c8454126.initial_effect(c)
	aux.AddCodeList(c,23459650)
	c:EnableReviveLimit()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(8454126,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,8454126)
	e1:SetCondition(c8454126.spcon)
	e1:SetTarget(c8454126.sptg)
	e1:SetOperation(c8454126.spop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(8454126,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_RELEASE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,8454127)
	e2:SetCondition(c8454126.descon)
	e2:SetOperation(c8454126.desop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_DESTROYED)
	c:RegisterEffect(e3)
end
function c8454126.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_RITUAL)
end
function c8454126.spfilter(c,e,tp)
	return c:IsSetCard(0x11f) and c:IsType(TYPE_RITUAL) and not c:IsCode(8454126) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,false,true)
end
function c8454126.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c8454126.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c8454126.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c8454126.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		tc:SetMaterial(nil)
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,false,true,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
function c8454126.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_EFFECT) and re:GetHandler():IsSetCard(0x11f)
end
function c8454126.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetCountLimit(1)
	if Duel.GetCurrentPhase()==PHASE_STANDBY then
		e1:SetLabel(Duel.GetTurnCount())
		e1:SetReset(RESET_PHASE+PHASE_STANDBY,2)
	else
		e1:SetLabel(0)
		e1:SetReset(RESET_PHASE+PHASE_STANDBY)
	end
	e1:SetCondition(c8454126.descon2)
	e1:SetTarget(c8454126.destg2)
	e1:SetOperation(c8454126.desop2)
	Duel.RegisterEffect(e1,tp)
end
function c8454126.descon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()~=e:GetLabel()
end
function c8454126.desfilter(c)
	return not (c:IsType(TYPE_RITUAL) and c:IsType(TYPE_MONSTER)) and c:IsSetCard(0x11f) and (c:IsFaceup() or c:IsLocation(LOCATION_HAND+LOCATION_DECK))
end
function c8454126.destg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c8454126.desfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_ONFIELD,0,1,nil) end
end
function c8454126.fselect(g)
	return g:FilterCount(Card.IsLocation,nil,LOCATION_HAND)<=1
		and g:FilterCount(Card.IsLocation,nil,LOCATION_DECK)<=1
		and g:FilterCount(Card.IsLocation,nil,LOCATION_ONFIELD)<=1
end
function c8454126.desop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,8454126)
	local g=Duel.GetMatchingGroup(c8454126.desfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_ONFIELD,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local sg=g:SelectSubGroup(tp,c8454126.fselect,false,1,3)
	Duel.Destroy(sg,REASON_EFFECT)
end
