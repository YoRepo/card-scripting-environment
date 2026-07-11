--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Laval Burner  (ID: 88958576)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level: 5
-- ATK 2100 | DEF 1000
-- Setcode: 0x39
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you have 3 or more "Laval" monsters with different names in your Graveyard, you can Special
-- Summon this card (from your hand).
--[[ __CARD_HEADER_END__ ]]

--ラヴァルバーナー
function c88958576.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c88958576.spcon)
	c:RegisterEffect(e1)
end
function c88958576.spcon(e,c)
	if c==nil then return true end
	if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)<=0 then return false end
	local g=Duel.GetMatchingGroup(Card.IsSetCard,c:GetControler(),LOCATION_GRAVE,0,nil,0x39)
	local ct=g:GetClassCount(Card.GetCode)
	return ct>=3
end
