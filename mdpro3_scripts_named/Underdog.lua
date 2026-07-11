--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Underdog  (ID: 5779502)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- During your turn, negate the effects of all face-up monsters your opponent controls.
-- During your opponent's turn, negate the effects of all face-up monsters you control.
--[[ __CARD_HEADER_END__ ]]

--形勢反転
function c5779502.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c5779502.disable)
	c:RegisterEffect(e2)
end
function c5779502.disable(e,c)
	return (c:IsType(TYPE_EFFECT) or bit.band(c:GetOriginalType(),TYPE_EFFECT)==TYPE_EFFECT) and c:IsControler(1-Duel.GetTurnPlayer())
end
