--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 与奈落的契约  (ID: 69035382)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 暗属性仪式怪兽的降临必需。
-- ①：等级合计直到变成和仪式召唤的怪兽相同为止，把自己的手卡·场上的怪兽解放，从手卡把1只暗属性仪式怪兽仪式召唤。
--[[ __CARD_HEADER_END__ ]]

--奈落との契約
function c69035382.initial_effect(c)
	aux.AddRitualProcEqual2(c,c69035382.ritual_filter)
end
function c69035382.ritual_filter(c)
	return c:IsType(TYPE_RITUAL) and c:IsAttribute(ATTRIBUTE_DARK)
end
