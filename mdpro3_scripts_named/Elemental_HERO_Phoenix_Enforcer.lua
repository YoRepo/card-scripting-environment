--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Elemental HERO Phoenix Enforcer  (ID: 41436536)
-- Type: Monster / Effect / Fusion
-- Attribute: FIRE
-- Race: Warrior
-- Level: 6
-- ATK 2100 | DEF 1200
-- Setcode: 0x3008
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Elemental HERO Avian" + "Elemental HERO Burstinatrix"
-- Must be Fusion Summoned and cannot be Special Summoned by other ways.
-- This card cannot be destroyed by battle.
--[[ __CARD_HEADER_END__ ]]

--E・HERO フェニックスガイ
function c41436536.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,21844576,58932615,true,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
c41436536.material_setcode=0x8
