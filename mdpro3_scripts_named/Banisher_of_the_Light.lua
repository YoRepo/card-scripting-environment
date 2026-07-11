--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Banisher of the Light  (ID: 61528025)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 3
-- ATK 100 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- Any card sent to the GY is banished instead.
--[[ __CARD_HEADER_END__ ]]

--光の追放者
function c61528025.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_DECK,LOCATION_DECK)
	e1:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e1)
end
