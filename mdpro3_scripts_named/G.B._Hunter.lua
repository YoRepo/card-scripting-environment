--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: G.B. Hunter  (ID: 4130270)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 4
-- ATK 1200 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cards on the field cannot be returned to the Deck.
--[[ __CARD_HEADER_END__ ]]

--G・B・ハンター
function c4130270.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_TO_DECK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsLocation,LOCATION_ONFIELD))
	c:RegisterEffect(e1)
end
