--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 查克拉的复活  (ID: 39399168)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「查克拉」的降临必要。必须从场上或者手札，牺牲奉献等级合计为7个以上的卡。
--[[ __CARD_HEADER_END__ ]]

--チャクラの復活
function c39399168.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,65393205)
end
