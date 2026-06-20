--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 黑混沌之魔术师  (ID: 30208479)
-- Type: Monster / Ritual
-- Attribute: DARK
-- Race: Spellcaster
-- Level 8
-- ATK 2800 | DEF 2600
-- Setcode: 207
--
-- Effect Text:
-- 「混沌-黑魔术的仪式」降临
--[[ __CARD_HEADER_END__ ]]

--マジシャン・オブ・ブラックカオス
function c30208479.initial_effect(c)
	aux.AddCodeList(c,76792184)
	c:EnableReviveLimit()
end
