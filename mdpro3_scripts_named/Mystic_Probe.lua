--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Mystic Probe  (ID: 49251811)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can activate this card when a Continuous Spell Card is activated.
-- Negate all Continuous Spell Cards during the turn this card is activated.
--[[ __CARD_HEADER_END__ ]]

--魔法探査の石版
function c49251811.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c49251811.condition)
	e1:SetOperation(c49251811.activate)
	c:RegisterEffect(e1)
end
function c49251811.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetActiveType()==TYPE_CONTINUOUS+TYPE_SPELL
end
function c49251811.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e1:SetTarget(c49251811.distarget)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c49251811.distarget(e,c)
	return c:GetType()==TYPE_CONTINUOUS+TYPE_SPELL
end
