--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 舞蹈战士  (ID: 4849037)
-- Type: Monster / Ritual
-- Attribute: EARTH
-- Race: Warrior
-- Level 6
-- ATK 1950 | DEF 1850
--
-- Effect Text:
-- 「诱发之舞」降临。必须从场地和手卡把等级直到6以上的卡作为祭品。
--[[ __CARD_HEADER_END__ ]]

--ダンシング・ソルジャー
function c4849037.initial_effect(c)
	aux.AddCodeList(c,43417563)
	c:EnableReviveLimit()
end
