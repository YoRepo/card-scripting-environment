--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Gendo the Ascetic Monk  (ID: 99000107)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Spellcaster
-- Level: 4
-- ATK 300 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- Face-up Attack Position monsters on the field cannot activate their effects.
-- This Defense Position card cannot be targeted, or destroyed, by card effects.
--[[ __CARD_HEADER_END__ ]]

--修禅僧 ゲンドウ
function c99000107.initial_effect(c)
	--Cannot activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetValue(c99000107.aclimit)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetCondition(c99000107.tgcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c99000107.aclimit(e,re,tp)
	local tc=re:GetHandler()
	return tc:IsLocation(LOCATION_MZONE) and tc:IsFaceup() and tc:IsAttackPos() and re:IsActiveType(TYPE_MONSTER)
end
function c99000107.tgcon(e)
	return e:GetHandler():IsDefensePos()
end
