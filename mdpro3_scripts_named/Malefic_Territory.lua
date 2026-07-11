--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Malefic Territory  (ID: 75223115)
-- Type: Spell / Continuous
-- Setcode: 0x23
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is activated: You can activate 1 "Malefic World" from your Deck.
-- While that card is in the Field Zone, neither player can target a card(s) in the Field Zone with
-- card effects.
-- The "Malefic" monster effect, "There can only be 1 face-up "Malefic" monster on the field" becomes
-- "There can only be 1 face-up "Malefic" monster on the field with the same name".
-- During the Battle Phase, negate the effects of face-up "Malefic" monsters on the field.
--[[ __CARD_HEADER_END__ ]]

--Sin Territory
function c75223115.initial_effect(c)
	aux.AddCodeList(c,27564031)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c75223115.activate)
	c:RegisterEffect(e1)
	--unique
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(75223115)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(1,1)
	c:RegisterEffect(e2)
	--disable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DISABLE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetCondition(c75223115.discon)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x23))
	c:RegisterEffect(e3)
end
function c75223115.actfilter(c,tp)
	return c:IsCode(27564031) and c:IsType(TYPE_FIELD) and c:GetActivateEffect():IsActivatable(tp,true,true)
end
function c75223115.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c75223115.actfilter,tp,LOCATION_DECK,0,nil,tp)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(75223115,0)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
		local sg=g:Select(tp,1,1,nil)
		local sc=sg:GetFirst()
		Duel.MoveToField(sc,tp,tp,LOCATION_FZONE,POS_FACEUP,true)
		local te=sc:GetActivateEffect()
		te:UseCountLimit(tp,1,true)
		local tep=sc:GetControler()
		local cost=te:GetCost()
		if cost then cost(te,tep,eg,ep,ev,re,r,rp,1) end
		Duel.RaiseEvent(sc,4179255,te,0,tp,tp,Duel.GetCurrentChain())
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
		e1:SetRange(LOCATION_FZONE)
		e1:SetTargetRange(LOCATION_FZONE,LOCATION_FZONE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		sc:RegisterEffect(e1)
	end
end
function c75223115.discon(e)
	local ph=Duel.GetCurrentPhase()
	return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE
end
