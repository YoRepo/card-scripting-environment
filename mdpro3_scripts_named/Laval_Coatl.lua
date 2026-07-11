--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Laval Coatl  (ID: 45439263)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Pyro
-- Level: 2
-- ATK 1300 | DEF 700
-- Setcode: 0x39
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you have 3 or more "Laval" monsters with different names in your Graveyard, you can Special
-- Summon this card (from your hand).
--[[ __CARD_HEADER_END__ ]]

--ラヴァル・コアトル
function c45439263.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c45439263.spcon)
	c:RegisterEffect(e1)
end
function c45439263.spcon(e,c)
	if c==nil then return true end
	if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)<=0 then return false end
	return Duel.GetMatchingGroup(Card.IsSetCard,c:GetControler(),LOCATION_GRAVE,0,nil,0x39):GetClassCount(Card.GetCode)>=3
end
