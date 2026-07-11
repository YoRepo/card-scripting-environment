--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Earth Effigy  (ID: 53461122)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level: 4
-- ATK 100 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be treated as 2 Tributes for the Tribute Summon of an EARTH Normal Monster.
--[[ __CARD_HEADER_END__ ]]

--ガイアフレーム
function c53461122.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c53461122.condition)
	c:RegisterEffect(e1)
end
function c53461122.condition(e,c)
	return c:IsAttribute(ATTRIBUTE_EARTH) and c:IsType(TYPE_NORMAL)
end
