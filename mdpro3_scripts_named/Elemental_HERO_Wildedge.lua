--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Elemental HERO Wildedge  (ID: 10526791)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Warrior
-- Level: 8
-- ATK 2600 | DEF 2300
-- Setcode: 0x3008
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Elemental HERO Wildheart" + "Elemental HERO Bladedge"
-- Must be Fusion Summoned.
-- This card can attack all monsters your opponent controls, once each.
--[[ __CARD_HEADER_END__ ]]

--E・HERO ワイルドジャギーマン
function c10526791.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,86188410,59793705,true,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--attackall
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_ATTACK_ALL)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
c10526791.material_setcode=0x8
