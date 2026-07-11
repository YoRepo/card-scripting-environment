--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Capricious Darklord  (ID: 55289183)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fairy
-- Level: 4
-- ATK 0 | DEF 1600
-- Setcode: 0xef
-- Scope: OCG / TCG
--
-- Effect Text:
-- During the Main Phase (Quick Effect): You can activate this effect; Tribute Summon 1 Fairy monster
-- face-up.
-- If this card is sent to the GY: You can make all monsters your opponent currently controls lose 500
-- ATK/DEF for each Fairy monster on the field, until the end of this turn.
-- You can only use each effect of "Capricious Darklord" once per turn.
--[[ __CARD_HEADER_END__ ]]

--享楽の堕天使
function c55289183.initial_effect(c)
	--tribute summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(55289183,0))
	e1:SetCategory(CATEGORY_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e1:SetCountLimit(1,55289183)
	e1:SetCondition(c55289183.sumcon)
	e1:SetTarget(c55289183.sumtg)
	e1:SetOperation(c55289183.sumop)
	c:RegisterEffect(e1)
	--atk/def
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(55289183,1))
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,55289184)
	e2:SetTarget(c55289183.atktg)
	e2:SetOperation(c55289183.atkop)
	c:RegisterEffect(e2)
end
function c55289183.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c55289183.sumfilter(c)
	return c:IsRace(RACE_FAIRY) and c:IsSummonable(true,nil,1)
end
function c55289183.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c55289183.sumfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c55289183.sumop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c55289183.sumfilter,tp,LOCATION_HAND,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.Summon(tp,tc,true,nil,1)
	end
end
function c55289183.atkfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_FAIRY)
end
function c55289183.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c55289183.atkfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
end
function c55289183.atkop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c55289183.atkfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	if ct>0 then
		local tc=g:GetFirst()
		while tc do
			local c=e:GetHandler()
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			e1:SetValue(-500*ct)
			tc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_UPDATE_DEFENSE)
			tc:RegisterEffect(e2)
			tc=g:GetNext()
		end
	end
end
