--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Gaia Dragon, the Thunder Charger  (ID: 91949988)
-- Type: Monster / Effect / Xyz
-- Attribute: WIND
-- Race: Dragon
-- Rank: 7
-- ATK 2600 | DEF 2100
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Level 7 monsters
-- You can also Xyz Summon this card by using a Rank 5 or 6 Xyz Monster you control as material.
-- (Transfer its materials to this card.)
-- If this card attacks a Defense Position monster, inflict piercing battle damage.
--[[ __CARD_HEADER_END__ ]]

--迅雷の騎士ガイアドラグーン
function c91949988.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,2,c91949988.ovfilter,aux.Stringid(91949988,0))
	c:EnableReviveLimit()
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
end
function c91949988.ovfilter(c)
	return c:IsFaceup() and c:IsRank(5,6)
end
