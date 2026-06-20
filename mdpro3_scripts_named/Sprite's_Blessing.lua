--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 精灵的祝福  (ID: 37626500)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 光属性仪式怪兽的降临必需。
-- ①：等级合计直到变成和仪式召唤的怪兽相同为止，把自己的手卡·场上的怪兽解放，从手卡把1只光属性仪式怪兽仪式召唤。
--[[ __CARD_HEADER_END__ ]]

--精霊の祝福
function c37626500.initial_effect(c)
	aux.AddRitualProcEqual2(c,c37626500.ritual_filter)
end
function c37626500.ritual_filter(c)
	return c:IsType(TYPE_RITUAL) and c:IsAttribute(ATTRIBUTE_LIGHT)
end
