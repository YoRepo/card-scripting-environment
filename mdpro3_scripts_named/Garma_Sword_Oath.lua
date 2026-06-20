--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 伽玛剑的誓言  (ID: 78577570)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「伽玛剑」的降临必需。
-- ①：从自己的手卡·场上把等级合计直到7以上的怪兽解放，从手卡把1只「伽玛剑」仪式召唤。
--[[ __CARD_HEADER_END__ ]]

--ガルマソードの誓い
function c78577570.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,90844184)
end
