--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 合成魔术  (ID: 72446038)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「合成狼人」的降临需要。必须从场上或手卡把合计6星以上的卡作为祭品。
--[[ __CARD_HEADER_END__ ]]

--合成魔術
function c72446038.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,84385264)
end
