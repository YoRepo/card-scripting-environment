--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 朱雀  (ID: 35752363)
-- Type: Monster / Fusion
-- Attribute: FIRE
-- Race: Pyro
-- Level 5
-- ATK 1900 | DEF 1500
--
-- Effect Text:
-- 「赤剑之莱蒙多斯」＋「炎之魔神」
--[[ __CARD_HEADER_END__ ]]

--朱雀
function c35752363.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,62403074,71407486,true,true)
end
