--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Invoked Cocytus  (ID: 85908279)
-- Type: Monster / Effect / Fusion
-- Attribute: WATER
-- Race: Dragon
-- Level: 6
-- ATK 1800 | DEF 2900
-- Setcode: 0xf4
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Aleister the Invoker" + 1 WATER monster
-- Cannot be destroyed by your opponent's card effects.
-- Your opponent cannot target this card with card effects.
-- Can attack while in face-up Defense Position.
-- If it does, apply its ATK for damage calculation.
--[[ __CARD_HEADER_END__ ]]

--召喚獣コキュートス
function c85908279.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,86120751,aux.FilterBoolFunction(Card.IsFusionAttribute,ATTRIBUTE_WATER),1,true,true)
	--cannot target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetValue(aux.tgoval)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(aux.indoval)
	c:RegisterEffect(e2)
	--defense attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DEFENSE_ATTACK)
	c:RegisterEffect(e3)
end
