--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Neo Flamvell Origin  (ID: 66378485)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Pyro
-- Level: 2
-- ATK 500 | DEF 200
-- Setcode: 0x2c
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a "Flamvell" monster, except "Neo Flamvell Origin", and your opponent has 3 or less
-- cards in their GY, you can Special Summon this card (from your hand).
--[[ __CARD_HEADER_END__ ]]

--ネオフレムベル・オリジン
function c66378485.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c66378485.spcon)
	c:RegisterEffect(e1)
end
function c66378485.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x2c) and not c:IsCode(66378485)
end
function c66378485.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c66378485.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
		and	Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_GRAVE)<=3
end
