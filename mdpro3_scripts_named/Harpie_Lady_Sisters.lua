--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-11-19T23:32:31
-- Source DB: cards.cdb
-- Card: Harpie Lady Sisters  (ID: 12206212)
-- Type: Monster / Effect / Special Summon
-- Attribute: WIND
-- Race: Winged Beast
-- Level: 6
-- ATK 1950 | DEF 2100
-- Setcode: 0x1064
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Normal Summoned/Set.
-- Must first be Special Summoned with "Elegant Egotist".
--[[ __CARD_HEADER_END__ ]]

--ハーピィ・レディ三姉妹
function c12206212.initial_effect(c)
	c:EnableReviveLimit()
end
