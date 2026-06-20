--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 骷髅骑手的复活  (ID: 31066283)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「骷髅骑手」降临必要。场上和手卡加起来总共6颗星以上的怪兽作祭品。
--[[ __CARD_HEADER_END__ ]]

--スカルライダーの復活
function c31066283.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,99721536)
end
