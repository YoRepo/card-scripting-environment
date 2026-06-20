--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 法理的祈祷  (ID: 43694075)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「法理守护者」的降临必要。必须从场上或者手札，牺牲奉献等级合计为7个以上的卡。
--[[ __CARD_HEADER_END__ ]]

--ローの祈り
function c43694075.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,3627449)
end
