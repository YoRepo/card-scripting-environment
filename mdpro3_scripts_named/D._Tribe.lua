--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: D. Tribe  (ID: 2833249)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- All monsters on your side of the field are treated as Dragon-Types until the End Phase of this turn.
--[[ __CARD_HEADER_END__ ]]

--竜の血族
function c2833249.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c2833249.target)
	e1:SetOperation(c2833249.operation)
	c:RegisterEffect(e1)
end
function c2833249.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
end
function c2833249.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_RACE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(RACE_DRAGON)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
