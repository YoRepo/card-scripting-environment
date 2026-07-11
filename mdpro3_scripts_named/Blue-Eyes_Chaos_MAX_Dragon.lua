--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Blue-Eyes Chaos MAX Dragon  (ID: 55410871)
-- Type: Monster / Effect / Ritual
-- Attribute: DARK
-- Race: Dragon
-- Level: 8
-- ATK 4000 | DEF 0
-- Setcode: 0xdd, 0xcf
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Ritual Summon this card with "Chaos Form".
-- Must be Ritual Summoned.
-- Your opponent cannot target this card with card effects, also it cannot be destroyed by your
-- opponent's card effects.
-- If this card attacks a Defense Position monster, inflict double piercing battle damage to your
-- opponent.
--[[ __CARD_HEADER_END__ ]]

--ブルーアイズ・カオス・MAX・ドラゴン
function c55410871.initial_effect(c)
	aux.AddCodeList(c,21082832)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.ritlimit)
	c:RegisterEffect(e1)
	--cannot target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(aux.indoval)
	c:RegisterEffect(e3)
	--pierce
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_PIERCE)
	e4:SetValue(DOUBLE_DAMAGE)
	c:RegisterEffect(e4)
end
