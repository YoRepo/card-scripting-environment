--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 恶魔镜的仪式  (ID: 81933259)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「恶魔镜」降临必要。场上和手卡加起来总共6颗星以上的怪兽作祭品。
--[[ __CARD_HEADER_END__ ]]

--悪魔鏡の儀式
function c81933259.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,31890399)
end
