--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 超级交通机人-巨大钻头  (ID: 36256625)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Machine
-- Level 8
-- ATK 3000 | DEF 2000
-- Setcode: 4118
--
-- Effect Text:
-- 「蒸汽机人」＋「钻头机人」＋「潜艇机人」
-- 这只怪兽的融合召唤只能用上记的卡进行。这张卡攻击守备表示怪兽时，若攻击力超过那个守备力，给与对方基本分那个数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--スーパービークロイド－ジャンボドリル
function c36256625.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode3(c,44729197,71218746,99861526,false,false)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
end
