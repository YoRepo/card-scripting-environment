--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Ancient Gear Knight  (ID: 39303359)
-- Type: Monster / Effect / Gemini
-- Attribute: EARTH
-- Race: Machine
-- Level: 4
-- ATK 1800 | DEF 500
-- Setcode: 0x7
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is treated as a Normal Monster while face-up on the field or in the GY.
-- While this card is a Normal Monster on the field, you can Normal Summon it to have it become an
-- Effect Monster with this effect.
-- ● If this card attacks, your opponent cannot activate any Spell/Trap Cards until the end of the
-- Damage Step.
--[[ __CARD_HEADER_END__ ]]

--古代の機械騎士
function c39303359.initial_effect(c)
	aux.EnableDualAttribute(c)
	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c39303359.aclimit)
	e1:SetCondition(c39303359.actcon)
	c:RegisterEffect(e1)
end
function c39303359.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c39303359.actcon(e)
	return aux.IsDualState(e) and Duel.GetAttacker()==e:GetHandler()
end
