--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 大邪神的仪式  (ID: 60369732)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「大邪神 雷瑟夫」降临必要。必须把场上·手卡合计8星以上的卡作为祭品。
--[[ __CARD_HEADER_END__ ]]

--大邪神の儀式
function c60369732.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,62420419)
end
