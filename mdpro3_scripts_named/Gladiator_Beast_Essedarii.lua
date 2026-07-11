--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Gladiator Beast Essedarii  (ID: 73285669)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Beast
-- Level: 5
-- ATK 2500 | DEF 1400
-- Setcode: 0x1019
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 "Gladiator Beast" monsters
-- Must first be Special Summoned (from your Extra Deck) by shuffling the above cards you control into
-- the Deck.
--[[ __CARD_HEADER_END__ ]]

--剣闘獣エセダリ
function c73285669.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x1019),2,true)
	aux.AddContactFusionProcedure(c,Card.IsAbleToDeckOrExtraAsCost,LOCATION_MZONE,0,aux.ContactFusionSendToDeck(c))
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c73285669.splimit)
	c:RegisterEffect(e1)
end
function c73285669.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
