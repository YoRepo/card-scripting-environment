--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Batteryman D  (ID: 55401221)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level: 1
-- ATK 0 | DEF 1900
-- Setcode: 0x28
-- Scope: OCG / TCG
--
-- Effect Text:
-- Your opponent cannot select a Thunder-Type monster you control as an attack target (except
-- "Batteryman D").
--[[ __CARD_HEADER_END__ ]]

--電池メン－単一型
function c55401221.initial_effect(c)
	--cannot be battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c55401221.atlimit)
	c:RegisterEffect(e1)
end
function c55401221.atlimit(e,c)
	return c:IsFaceup() and c:IsRace(RACE_THUNDER) and not c:IsCode(55401221)
end
