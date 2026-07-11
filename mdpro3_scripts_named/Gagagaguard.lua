--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Gagagaguard  (ID: 76972801)
-- Type: Trap
-- Setcode: 0x54
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control 2 or more "Gagaga" monsters: This turn, monsters you control cannot be destroyed by
-- battle or by card effects.
--[[ __CARD_HEADER_END__ ]]

--ガガガガード
function c76972801.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c76972801.condition)
	e1:SetOperation(c76972801.activate)
	c:RegisterEffect(e1)
end
function c76972801.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x54)
end
function c76972801.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c76972801.cfilter,tp,LOCATION_MZONE,0,2,nil)
end
function c76972801.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetValue(1)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	Duel.RegisterEffect(e2,tp)
end
