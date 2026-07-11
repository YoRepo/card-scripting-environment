--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Dodger Dragon  (ID: 47013502)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Dragon
-- Level: 4
-- ATK 1900 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card's Normal Summon cannot be negated.
-- After this card was Normal Summoned, your opponent cannot activate Counter Trap Cards for the rest
-- of that turn.
--[[ __CARD_HEADER_END__ ]]

--アボイド・ドラゴン
function c47013502.initial_effect(c)
	--summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e1)
	--summon success
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetOperation(c47013502.sumsuc)
	c:RegisterEffect(e2)
end
function c47013502.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetValue(c47013502.actlimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c47013502.actlimit(e,te,tp)
	return te:GetHandler():IsType(TYPE_COUNTER)
end
