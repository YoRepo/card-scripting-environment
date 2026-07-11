--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Lesser Fiend  (ID: 16475472)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 5
-- ATK 2100 | DEF 1000
-- Setcode: 0x45
-- Scope: OCG / TCG
--
-- Effect Text:
-- (This card is always treated as an "Archfiend" card.)
-- Banish any monster destroyed by battle with this card.
--[[ __CARD_HEADER_END__ ]]

--レッサー・デーモン
function c16475472.initial_effect(c)
	--redirect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_BATTLE_DESTROY_REDIRECT)
	e1:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e1)
end
