--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Wind Effigy  (ID: 99865167)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level: 4
-- ATK 1800 | DEF 200
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be treated as 2 Tributes for the Tribute Summon of a WIND Normal Monster.
--[[ __CARD_HEADER_END__ ]]

--ウィンドフレーム
function c99865167.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c99865167.condition)
	c:RegisterEffect(e1)
end
function c99865167.condition(e,c)
	return c:IsAttribute(ATTRIBUTE_WIND) and c:IsType(TYPE_NORMAL)
end
