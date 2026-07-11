--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Noble Knight Gawayn  (ID: 19680539)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 4
-- ATK 1900 | DEF 500
-- Setcode: 0x107a
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a LIGHT Normal Monster, you can Special Summon this card (from your hand) in Defense
-- Position.
--[[ __CARD_HEADER_END__ ]]

--聖騎士ガウェイン
function c19680539.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_SPSUM_PARAM)
	e1:SetTargetRange(POS_FACEUP_DEFENSE,0)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c19680539.spcon)
	c:RegisterEffect(e1)
end
function c19680539.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_NORMAL) and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c19680539.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c19680539.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
