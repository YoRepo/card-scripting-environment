--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Cyber End Dragon  (ID: 1546123)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Machine
-- Level: 10
-- ATK 4000 | DEF 2800
-- Setcode: 0x93
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Cyber Dragon" + "Cyber Dragon" + "Cyber Dragon"
-- A Fusion Summon of this card can only be done with the above materials.
-- If this card attacks a Defense Position monster, inflict piercing battle damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--サイバー・エンド・ドラゴン
function c1546123.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,70095154,3,false,false)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
end
c1546123.material_setcode=0x1093
