--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 假面魔兽的仪式  (ID: 94377247)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「假面魔兽 鬼面修道士」的降临必需。
-- ①：从自己的手卡·场上把等级合计直到8以上的怪兽解放，从手卡把「假面魔兽 鬼面修道士」仪式召唤。
--[[ __CARD_HEADER_END__ ]]

--仮面魔獣の儀式
function c94377247.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,49064413)
end
