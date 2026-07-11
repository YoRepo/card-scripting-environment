--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Gaia the Dragon Champion  (ID: 66889139)
-- Type: Monster / Fusion
-- Attribute: WIND
-- Race: Dragon
-- Level: 7
-- ATK 2600 | DEF 2100
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Gaia The Fierce Knight" + "Curse of Dragon"
--[[ __CARD_HEADER_END__ ]]

--竜騎士ガイア
function c66889139.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,6368038,28279543,true,true)
end
