--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Chronomaly Tula Guardian  (ID: 5291803)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level: 5
-- ATK 1800 | DEF 900
-- Setcode: 0x70, 0x52
-- Scope: OCG / TCG
--
-- Effect Text:
-- If there is a face-up Field Spell Card on the field, you can Special Summon this card (from your
-- hand).
-- You can only control 1 "Chronomaly Tula Guardian".
--[[ __CARD_HEADER_END__ ]]

--先史遺産トゥーラ・ガーディアン
function c5291803.initial_effect(c)
	c:SetUniqueOnField(1,0,5291803)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c5291803.spcon)
	c:RegisterEffect(e1)
end
function c5291803.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_FZONE,LOCATION_FZONE,1,nil)
end
