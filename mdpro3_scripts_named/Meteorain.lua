--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Meteorain  (ID: 64274292)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- During this turn, when your monsters attack with an ATK that is higher than the DEF of your
-- opponent's Defense Position monster, inflict the difference as Battle Damage to your opponent's Life
-- Points.
--[[ __CARD_HEADER_END__ ]]

--メテオ・レイン
function c64274292.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c64274292.condition)
	e1:SetOperation(c64274292.activate)
	c:RegisterEffect(e1)
end
function c64274292.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c64274292.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
