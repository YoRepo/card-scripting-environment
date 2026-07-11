--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Landoise's Luminous Moss  (ID: 74717840)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate only if you control a face-up "Naturia" monster.
-- The opponent's Effect Monsters cannot activate their effects this turn.
--[[ __CARD_HEADER_END__ ]]

--ランドオルスのヒカリゴケ
function c74717840.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c74717840.condition)
	e1:SetOperation(c74717840.operation)
	c:RegisterEffect(e1)
end
function c74717840.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2a)
end
function c74717840.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c74717840.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c74717840.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c74717840.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c74717840.aclimit(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER)
end
