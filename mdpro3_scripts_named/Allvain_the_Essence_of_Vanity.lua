--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Allvain the Essence of Vanity  (ID: 3544583)
-- Type: Monster / Fusion / Tuner
-- Attribute: DARK
-- Race: Fairy
-- Level: 2
-- ATK 0 | DEF 2100
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Normal Monsters
--[[ __CARD_HEADER_END__ ]]

--無の畢竟 オールヴェイン
function c3544583.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionType,TYPE_NORMAL),2,true)
end
