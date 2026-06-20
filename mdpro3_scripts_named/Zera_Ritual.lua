--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 杰拉的仪式  (ID: 81756897)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 召唤「杰拉」降临必要。场上和手卡加起来总共8颗星以上的怪兽作祭品。
--[[ __CARD_HEADER_END__ ]]

--ゼラの儀式
function c81756897.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,69123138)
end
