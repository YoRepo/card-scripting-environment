--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Mavelus  (ID: 59036972)
-- Type: Monster / Fusion
-- Attribute: WIND
-- Race: Winged Beast
-- Level: 4
-- ATK 1300 | DEF 900
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Tyhone" + "Wings of Wicked Flame"
--[[ __CARD_HEADER_END__ ]]

--マブラス
function c59036972.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,72842870,92944626,true,true)
end
