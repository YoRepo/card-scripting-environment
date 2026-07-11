--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Timidity  (ID: 40350910)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- Neither player can destroy Set Spell and Trap Cards on the field until your opponent's next End
-- Phase.
--[[ __CARD_HEADER_END__ ]]

--おくびょうかぜ
function c40350910.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c40350910.activate)
	c:RegisterEffect(e1)
end
function c40350910.activate(e,tp,eg,ep,ev,re,r,rp)
	--indestructable
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetTarget(c40350910.infilter)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e1,tp)
end
function c40350910.infilter(e,c)
	return c:IsFacedown()
end
