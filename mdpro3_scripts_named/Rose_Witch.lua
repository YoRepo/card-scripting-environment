--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Rose Witch  (ID: 23087070)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level: 4
-- ATK 1600 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be treated as 2 Tributes for the Tribute Summon of a Plant monster.
--[[ __CARD_HEADER_END__ ]]

--ローズ・ウィッチ
function c23087070.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c23087070.condition)
	c:RegisterEffect(e1)
end
function c23087070.condition(e,c)
	return c:IsRace(RACE_PLANT)
end
