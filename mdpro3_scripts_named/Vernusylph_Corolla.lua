--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Vernusylph Corolla  (ID: 14108995)
-- Type: Spell / Continuous
-- Setcode: 0x182
-- Scope: OCG / TCG
--
-- Effect Text:
-- All EARTH monsters you control are also treated as "Vernusylph" monsters.
-- Once per turn, if you would discard a "Vernusylph" monster(s) and 1 card to activate the effect of
-- that "Vernusylph" monster in your hand, you can discard only that "Vernusylph" monster(s) instead.
--[[ __CARD_HEADER_END__ ]]

--春化精の花冠
function c14108995.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--add setcode
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsAttribute,ATTRIBUTE_EARTH))
	e2:SetCode(EFFECT_ADD_SETCODE)
	e2:SetValue(0x182)
	c:RegisterEffect(e2)
	--change cost
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(14108995)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCountLimit(1)
	e3:SetTargetRange(1,0)
	c:RegisterEffect(e3)
end
