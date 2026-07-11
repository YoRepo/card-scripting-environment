--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Ceremonial Bell  (ID: 20228463)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level: 3
-- ATK 0 | DEF 1850
-- Scope: OCG / TCG
--
-- Effect Text:
-- Both players must keep their hands revealed.
--[[ __CARD_HEADER_END__ ]]

--セレモニーベル
function c20228463.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PUBLIC)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_HAND,LOCATION_HAND)
	c:RegisterEffect(e1)
end
