--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 诱发之舞  (ID: 43417563)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「舞蹈战士」的降临必需。若不从场地和手卡把等级直到6以上的卡作为祭品，则「舞蹈战士」不能降临。
--[[ __CARD_HEADER_END__ ]]

--踊りによる誘発
function c43417563.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,4849037)
end
