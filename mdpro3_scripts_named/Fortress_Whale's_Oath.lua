--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 要塞鲸的誓言  (ID: 77454922)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「要塞鲸」的降临必要。必须从场上或者手札，牺牲奉献等级合计为7个以上的卡。
--[[ __CARD_HEADER_END__ ]]

--要塞クジラの誓い
function c77454922.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,62337487)
end
