--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 世界末日  (ID: 8198712)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
-- Setcode: 474
--
-- Effect Text:
-- ①：等级合计直到变成和仪式召唤的怪兽相同为止，把自己的手卡·场上的怪兽解放，从手卡把「破灭之女神 露茵」或「终焉之王 迪米斯」仪式召唤。
--[[ __CARD_HEADER_END__ ]]

--エンド・オブ・ザ・ワールド
function c8198712.initial_effect(c)
	aux.AddRitualProcEqual2Code2(c,72426662,46427957)
end
