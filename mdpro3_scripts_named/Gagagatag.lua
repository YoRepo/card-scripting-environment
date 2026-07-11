--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Gagagatag  (ID: 917796)
-- Type: Spell
-- Setcode: 0x54
-- Scope: OCG / TCG
--
-- Effect Text:
-- All "Gagaga" monsters you currently control gain 500 ATK for each "Gagaga" monster you currently
-- control, until your next Standby Phase.
-- You can only activate 1 "Gagagatag" per turn.
--[[ __CARD_HEADER_END__ ]]

--ガガガタッグ
function c917796.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,917796+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c917796.target)
	e1:SetOperation(c917796.activate)
	c:RegisterEffect(e1)
end
function c917796.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x54)
end
function c917796.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c917796.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c917796.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c917796.filter,tp,LOCATION_MZONE,0,nil)
	local atk=sg:GetCount()*500
	local c=e:GetHandler()
	local tc=sg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_STANDBY,2)
		tc:RegisterEffect(e1)
		tc=sg:GetNext()
	end
end
