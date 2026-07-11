--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Night Wing Sorceress  (ID: 49826746)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Spellcaster
-- Level: 3
-- ATK 1300 | DEF 1200
-- Setcode: 0x98
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can activate "Assault Mode Activate" the turn it is Set.
--[[ __CARD_HEADER_END__ ]]

--黒翼の魔術師
function c49826746.initial_effect(c)
	aux.AddCodeList(c,80280737)
	--Trap activate in set turn
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(49826746,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_SZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsCode,80280737))
	c:RegisterEffect(e1)
end
