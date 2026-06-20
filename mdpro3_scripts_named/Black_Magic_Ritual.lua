--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 混沌-黑魔术的仪式  (ID: 76792184)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
-- Setcode: 207
--
-- Effect Text:
-- 「黑混沌之魔术师」的降临必需。必须从自己的手卡·场上把等级合计直到8以上的怪兽解放。
--[[ __CARD_HEADER_END__ ]]

--カオス－黒魔術の儀式
function c76792184.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,30208479)
end
