--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 狮子的仪式  (ID: 54539105)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「超级战狮」的降临必需。必须从手卡·自己场上把等级合计直到7以上的怪兽解放。
--[[ __CARD_HEADER_END__ ]]

--ライオンの儀式
function c54539105.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,33951077)
end
