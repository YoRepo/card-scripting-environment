--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Darklord Nurse Reficule  (ID: 67316075)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fairy
-- Level: 4
-- ATK 1400 | DEF 600
-- Setcode: 0xef
-- Scope: OCG / TCG
--
-- Effect Text:
-- Any effect that would make your opponent gain LP inflicts the same amount of damage to them,
-- instead.
--[[ __CARD_HEADER_END__ ]]

--堕天使ナース－レフィキュル
function c67316075.initial_effect(c)
	--recover conversion
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_REVERSE_RECOVER)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
