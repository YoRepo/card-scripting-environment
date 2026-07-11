--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Black Skull Dragon  (ID: 11901678)
-- Type: Monster / Fusion
-- Attribute: DARK
-- Race: Dragon
-- Level: 9
-- ATK 3200 | DEF 2500
-- Setcode: 0x45
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Summoned Skull" + "Red-Eyes Black Dragon"
--
-- (This card is always treated as an "Archfiend" card.)
--[[ __CARD_HEADER_END__ ]]

--ブラック・デーモンズ・ドラゴン
function c11901678.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,70781052,74677422,true,true)
end
c11901678.material_setcode=0x3b
