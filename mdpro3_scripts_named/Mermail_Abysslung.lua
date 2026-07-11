--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Mermail Abysslung  (ID: 95466842)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level: 4
-- ATK 1200 | DEF 1800
-- Setcode: 0x74, 0x75
-- Scope: OCG / TCG
--
-- Effect Text:
-- Your opponent's monsters cannot target WATER monsters for attacks, except this one.
-- All WATER monsters you control gain 300 ATK.
--[[ __CARD_HEADER_END__ ]]

--水精鱗－アビスラング
function c95466842.initial_effect(c)
	--at limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c95466842.atlimit)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsAttribute,ATTRIBUTE_WATER))
	e2:SetValue(300)
	c:RegisterEffect(e2)
end
function c95466842.atlimit(e,c)
	return c~=e:GetHandler() and c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER)
end
