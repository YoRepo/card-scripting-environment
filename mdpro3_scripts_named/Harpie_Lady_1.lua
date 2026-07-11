--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Harpie Lady 1  (ID: 91932350)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level: 4
-- ATK 1300 | DEF 1400
-- Setcode: 0x64
-- Alias of: 76812113
-- Scope: OCG / TCG
--
-- Effect Text:
-- (This card's name is always treated as "Harpie Lady".)
-- All WIND monsters on the field gain 300 ATK.
--[[ __CARD_HEADER_END__ ]]

--ハーピィ・レディ1
function c91932350.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsAttribute,ATTRIBUTE_WIND))
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetValue(300)
	c:RegisterEffect(e1)
end
