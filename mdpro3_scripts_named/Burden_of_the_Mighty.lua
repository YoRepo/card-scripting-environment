--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Burden of the Mighty  (ID: 44947065)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Each face-up monster your opponent controls loses 100 ATK x its own Level.
--[[ __CARD_HEADER_END__ ]]

--強者の苦痛
function c44947065.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk down
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetValue(c44947065.val)
	c:RegisterEffect(e2)
end
function c44947065.val(e,c)
	return c:GetLevel()*-100
end
