--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Cyber Twin Dragon  (ID: 74157028)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Machine
-- Level: 8
-- ATK 2800 | DEF 2100
-- Setcode: 0x93
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Cyber Dragon" + "Cyber Dragon"
-- A Fusion Summon of this card can only be done with the above materials.
-- Can make a second attack during each Battle Phase.
--[[ __CARD_HEADER_END__ ]]

--サイバー・ツイン・ドラゴン
function c74157028.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,70095154,2,false,false)
	--extra att
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
c74157028.material_setcode=0x1093
