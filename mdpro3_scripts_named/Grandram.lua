--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Grandram  (ID: 35866404)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level: 4
-- ATK 0 | DEF 1400
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your opponent controls a face-up Xyz Monster, you can Special Summon this card (from your hand)
-- in face-up Attack Position.
--[[ __CARD_HEADER_END__ ]]

--グランドラン
function c35866404.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_SPSUM_PARAM)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(POS_FACEUP_ATTACK,0)
	e1:SetCondition(c35866404.spcon)
	c:RegisterEffect(e1)
end
function c35866404.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c35866404.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c35866404.filter,c:GetControler(),0,LOCATION_MZONE,1,nil)
end
