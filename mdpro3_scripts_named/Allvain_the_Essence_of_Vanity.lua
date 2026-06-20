--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 无之毕竟  (ID: 3544583)
-- Type: Monster / Fusion / Tuner
-- Attribute: DARK
-- Race: Fairy
-- Level 2
-- ATK 0 | DEF 2100
--
-- Effect Text:
-- 通常怪兽×2
--[[ __CARD_HEADER_END__ ]]

--無の畢竟 オールヴェイン
function c3544583.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionType,TYPE_NORMAL),2,true)
end
