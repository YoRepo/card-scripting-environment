--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Grass Phantom  (ID: 41249545)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Plant
-- Level: 3
-- ATK 1000 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card gains 500 ATK for each "Grass Phantom" in your Graveyard.
--[[ __CARD_HEADER_END__ ]]

--グラスファントム
function c41249545.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c41249545.atkup)
	c:RegisterEffect(e1)
end
function c41249545.atkup(e,c)
	return Duel.GetMatchingGroupCount(Card.IsCode,c:GetControler(),LOCATION_GRAVE,0,nil,41249545)*500
end
