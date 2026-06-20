--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 与暗之支配者的契约  (ID: 96420087)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「暗之支配者-佐克」的降临必需。
-- ①：从自己的手卡·场上把等级合计直到8以上的怪兽解放，从手卡把「暗之支配者-佐克」仪式召唤。
--[[ __CARD_HEADER_END__ ]]

--闇の支配者との契約
function c96420087.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,97642679)
end
