--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Time to Stand Up  (ID: 68490573)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a Dragon Synchro Monster is on the field: Special Summon up to 2 monsters, that are "Resonator"
-- monsters and/or Level 1 Dragon monsters, from your Deck.
-- When a monster effect is activated, while you control a Level 10 or higher DARK Dragon Synchro
-- Monster: You can banish this card from your GY; negate that effect, and if you do, 1 Synchro Monster
-- you control gains 2000 ATK until the end of the next turn.
-- You can only use each effect of "Time to Stand Up" once per turn.
--[[ __CARD_HEADER_END__ ]]

--大いなる魂
function c68490573.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCountLimit(1,68490573)
	e1:SetCondition(c68490573.condition)
	e1:SetTarget(c68490573.target)
	e1:SetOperation(c68490573.activate)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,68490574)
	e2:SetCondition(c68490573.discon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c68490573.distg)
	e2:SetOperation(c68490573.disop)
	c:RegisterEffect(e2)
end
function c68490573.filter(c)
	return c:IsRace(RACE_DRAGON) and c:IsType(TYPE_SYNCHRO) and c:IsFaceup()
end
function c68490573.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c68490573.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c68490573.spfilter(c,e,tp)
	return (c:IsSetCard(0x57) or c:IsRace(RACE_DRAGON) and c:IsLevel(1)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c68490573.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c68490573.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c68490573.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	if ft>=2 then ft=2 end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c68490573.spfilter,tp,LOCATION_DECK,0,1,ft,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c68490573.disfilter(c)
	return c:IsRace(RACE_DRAGON) and c:IsAttribute(ATTRIBUTE_DARK) and c:IsType(TYPE_SYNCHRO) and c:IsLevelAbove(10) and c:IsFaceup()
end
function c68490573.discon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c68490573.disfilter,tp,LOCATION_MZONE,0,1,nil)
		and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainDisablable(ev)
end
function c68490573.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c68490573.atkfilter(c)
	return c:IsType(TYPE_SYNCHRO) and c:IsFaceup()
end
function c68490573.disop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c68490573.atkfilter,tp,LOCATION_MZONE,0,nil)
	if Duel.NegateEffect(ev) and g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(68490573,2))
		local tg=g:Select(tp,1,1,nil)
		Duel.HintSelection(tg)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(2000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
		tg:GetFirst():RegisterEffect(e1)
	end
end
