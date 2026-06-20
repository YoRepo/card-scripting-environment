--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:29
-- Card: 魔导骑士 基尔提亚  (ID: 51828629)
-- Type: Monster / Fusion
-- Attribute: LIGHT
-- Race: Warrior
-- Level 5
-- ATK 1850 | DEF 1500
--
-- Effect Text:
-- 「冥界的番人」＋「王座守护者」
--[[ __CARD_HEADER_END__ ]]

--魔導騎士ギルティア
function c51828629.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,89272878,10071456,true,true)
end
