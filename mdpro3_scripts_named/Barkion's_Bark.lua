--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Barkion's Bark  (ID: 11813722)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate only if you control a face-up "Naturia" monster.
-- Your opponent cannot activate Trap Cards this turn.
--[[ __CARD_HEADER_END__ ]]

--パルキオンのうろこ
function c11813722.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c11813722.condition)
	e1:SetOperation(c11813722.operation)
	c:RegisterEffect(e1)
end
function c11813722.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2a)
end
function c11813722.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c11813722.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c11813722.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c11813722.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c11813722.aclimit(e,re,tp)
	return re:GetHandler():IsType(TYPE_TRAP) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
