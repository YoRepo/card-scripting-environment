--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Elemental Mistress Doriado  (ID: 99414168)
-- Type: Monster / Effect / Ritual
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level: 3
-- ATK 1200 | DEF 1400
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can only be Ritual Summoned with the Ritual Spell Card, "Doriado's Blessing".
-- The Attribute of this card is also treated as WIND, WATER, FIRE, and EARTH while it is face-up on
-- the field.
--[[ __CARD_HEADER_END__ ]]

--精霊術師 ドリアード
function c99414168.initial_effect(c)
	aux.AddCodeList(c,23965037)
	c:EnableReviveLimit()
	--Attribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_ADD_ATTRIBUTE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(0xf)
	c:RegisterEffect(e1)
end
