--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Tactical Espionage Expert  (ID: 89698120)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 3
-- ATK 1300 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Normal Summoned successfully, no Trap Cards can be activated.
--[[ __CARD_HEADER_END__ ]]

--華麗なる潜入工作員
function c89698120.initial_effect(c)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c89698120.sumsuc)
	c:RegisterEffect(e1)
end
function c89698120.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimitTillChainEnd(c89698120.chlimit)
end
function c89698120.chlimit(re,rp,tp)
	return not re:GetHandler():IsType(TYPE_TRAP) or not re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
