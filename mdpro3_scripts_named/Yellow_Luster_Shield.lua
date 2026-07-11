--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Yellow Luster Shield  (ID: 4542651)
-- Type: Spell / Continuous
-- Setcode: 0xcf
-- Scope: OCG / TCG
--
-- Effect Text:
-- Increase the DEF of all monsters on your side of the field by 300 points.
--[[ __CARD_HEADER_END__ ]]

--カオス・シールド
function c4542651.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Def up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetValue(300)
	c:RegisterEffect(e2)
end
