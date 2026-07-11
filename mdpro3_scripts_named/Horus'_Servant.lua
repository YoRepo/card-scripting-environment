--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Horus' Servant  (ID: 9264485)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Beast-Warrior
-- Level: 1
-- ATK 100 | DEF 100
-- Setcode: 0x19d
-- Scope: OCG / TCG
--
-- Effect Text:
-- Your opponent cannot target face-up "Horus the Black Flame Dragon" monsters with Spells, Traps, or
-- card effects.
--[[ __CARD_HEADER_END__ ]]

--ホルスのしもべ
function c9264485.initial_effect(c)
	--cannot be target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x119d))
	e1:SetValue(aux.tgoval)
	c:RegisterEffect(e1)
end
