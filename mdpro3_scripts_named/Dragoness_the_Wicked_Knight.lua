--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 魔装骑士 德拉格尼斯  (ID: 70681994)
-- Type: Monster / Fusion
-- Attribute: WIND
-- Race: Warrior
-- Level 3
-- ATK 1200 | DEF 900
--
-- Effect Text:
-- 「铠甲剑尾战士」＋「独眼盾龙」
--[[ __CARD_HEADER_END__ ]]

--魔装騎士ドラゴネス
function c70681994.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,53153481,33064647,true,true)
end
