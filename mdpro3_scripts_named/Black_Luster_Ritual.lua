--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 混沌的仪式  (ID: 55761792)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
-- Setcode: 207
--
-- Effect Text:
-- 「混沌战士」的降临必需。
-- ①：从自己的手卡·场上把等级合计直到8以上的怪兽解放，从手卡把「混沌战士」仪式召唤。
--[[ __CARD_HEADER_END__ ]]

--カオスの儀式
function c55761792.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,5405694)
end
