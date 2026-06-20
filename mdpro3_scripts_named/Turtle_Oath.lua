--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 龟的誓言  (ID: 76806714)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「蟹龟」的降临必需。若不从场地和手卡把等级直到8以上的卡作为祭品，则「蟹龟」不能降临。
--[[ __CARD_HEADER_END__ ]]

--亀の誓い
function c76806714.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,91782219)
end
