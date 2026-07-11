--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Chronomaly Mayan Machine  (ID: 25163248)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level: 3
-- ATK 1500 | DEF 700
-- Setcode: 0x70
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be treated as 2 Tributes for the Tribute Summon of a Machine-Type monster.
--[[ __CARD_HEADER_END__ ]]

--先史遺産マヤン・マシーン
function c25163248.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c25163248.condition)
	c:RegisterEffect(e1)
end
function c25163248.condition(e,c)
	return c:IsRace(RACE_MACHINE)
end
