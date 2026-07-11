--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Ancient Gear Golem  (ID: 83104731)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level: 8
-- ATK 3000 | DEF 3000
-- Setcode: 0x7
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Special Summoned.
-- If this card attacks, your opponent cannot activate any Spell/Trap Cards until the end of the Damage
-- Step.
-- If this card attacks a Defense Position monster, inflict piercing battle damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--古代の機械巨人
function c83104731.initial_effect(c)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
	--actlimit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EFFECT_CANNOT_ACTIVATE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,1)
	e3:SetValue(c83104731.aclimit)
	e3:SetCondition(c83104731.actcon)
	c:RegisterEffect(e3)
end
function c83104731.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c83104731.actcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end
