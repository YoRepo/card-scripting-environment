--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 汉堡的食谱  (ID: 80811661)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
-- Setcode: 407
--
-- Effect Text:
-- 「饥饿的汉堡」的降临必需。
-- ①：从自己的手卡·场上把等级合计直到6以上的怪兽解放，从手卡把「饥饿的汉堡」仪式召唤。
--[[ __CARD_HEADER_END__ ]]

--ハンバーガーのレシピ
function c80811661.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,30243636)
end
