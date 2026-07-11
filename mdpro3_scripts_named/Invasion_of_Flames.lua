--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Invasion of Flames  (ID: 26082229)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level: 3
-- ATK 1300 | DEF 1200
-- Setcode: 0x65
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Normal Summoned successfully, no Trap Cards can be activated.
--[[ __CARD_HEADER_END__ ]]

--侵略の炎
function c26082229.initial_effect(c)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c26082229.sumsuc)
	c:RegisterEffect(e1)
end
function c26082229.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimitTillChainEnd(c26082229.chlimit)
end
function c26082229.chlimit(re,rp,tp)
	return not re:GetHandler():IsType(TYPE_TRAP) or not re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
