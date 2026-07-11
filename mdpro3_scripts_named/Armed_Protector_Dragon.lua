--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Armed Protector Dragon  (ID: 29330706)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Dragon
-- Level: 8
-- ATK 2000 | DEF 2800
-- Scope: OCG / TCG
--
-- Effect Text:
-- Face-up Equip Cards you control cannot be destroyed by card effects.
-- This card gains 500 ATK for each Equip Card equipped to this card.
--[[ __CARD_HEADER_END__ ]]

--武装神竜プロテクト・ドラゴン
function c29330706.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetTargetRange(LOCATION_SZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_EQUIP))
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c29330706.val)
	c:RegisterEffect(e2)
end
function c29330706.val(e,c)
	return c:GetEquipCount()*500
end
