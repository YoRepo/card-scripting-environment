--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 幻想的仪式  (ID: 41426869)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「纳祭之魔」的降临必需。
-- ①：等级合计直到1以上的自己的手卡·场上的怪兽解放，从手卡把「纳祭之魔」仪式召唤。
--[[ __CARD_HEADER_END__ ]]

--イリュージョンの儀式
function c41426869.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,64631466)
end
