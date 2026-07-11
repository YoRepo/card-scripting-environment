--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Ally of Justice Thunder Armor  (ID: 71438011)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level: 8
-- ATK 2700 | DEF 2200
-- Setcode: 0x1
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Special Summoned.
-- If your "Ally of Justice" monster attacks a Defense Position monster, inflict piercing battle damage
-- to your opponent.
--[[ __CARD_HEADER_END__ ]]

--A・O・J サンダー・アーマー
function c71438011.initial_effect(c)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_PIERCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x1))
	c:RegisterEffect(e2)
end
