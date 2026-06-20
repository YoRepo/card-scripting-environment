--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 白龙降临  (ID: 9786492)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「白龙之圣骑士」的降临必需。
-- ①：等级合计直到4以上的自己的手卡·场上的怪兽解放，从手卡把「白龙之圣骑士」仪式召唤。
--[[ __CARD_HEADER_END__ ]]

--白竜降臨
function c9786492.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,73398797)
end
