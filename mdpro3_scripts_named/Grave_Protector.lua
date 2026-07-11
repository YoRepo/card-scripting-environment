--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Grave Protector  (ID: 11448373)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 4
-- ATK 0 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- Any monster destroyed by battle is shuffled into the Deck instead of going to the GY.
--[[ __CARD_HEADER_END__ ]]

--グレイヴ・キーパー
function c11448373.initial_effect(c)
	--todeck
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_BATTLE_DESTROY_REDIRECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetValue(LOCATION_DECKSHF)
	c:RegisterEffect(e1)
end
