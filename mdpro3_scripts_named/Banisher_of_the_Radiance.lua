--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Banisher of the Radiance  (ID: 94853057)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 3
-- ATK 1600 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- Any card sent to the GY is banished instead.
--[[ __CARD_HEADER_END__ ]]

--閃光の追放者
function c94853057.initial_effect(c)
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
