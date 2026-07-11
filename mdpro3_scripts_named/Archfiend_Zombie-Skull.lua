--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Archfiend Zombie-Skull  (ID: 59969392)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Zombie
-- Level: 6
-- ATK 2500 | DEF 1200
-- Setcode: 0x45
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Plaguespreader Zombie" + 2+ non-Tuner Zombie monsters
-- Zombie monsters you control cannot be destroyed by card effects.
--[[ __CARD_HEADER_END__ ]]

--アンデット・スカル・デーモン
function c59969392.initial_effect(c)
	aux.AddMaterialCodeList(c,33420078)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsCode,33420078),aux.NonTuner(Card.IsRace,RACE_ZOMBIE),2)
	c:EnableReviveLimit()
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_ZOMBIE))
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
