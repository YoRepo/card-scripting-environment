--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Maiden of the Aqua  (ID: 17214465)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level: 4
-- ATK 700 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- While there is no face-up Field Spell, the field is treated as "Umi".
--[[ __CARD_HEADER_END__ ]]

--海神の巫女
function c17214465.initial_effect(c)
	aux.AddCodeList(c,22702055)
	--field
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CHANGE_ENVIRONMENT)
	e1:SetValue(22702055)
	c:RegisterEffect(e1)
end
