--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Chronomaly Moai  (ID: 87430304)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level: 5
-- ATK 1800 | DEF 1600
-- Setcode: 0x70
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a "Chronomaly" monster, you can Special Summon this card (from your hand) in Defense
-- Position.
--[[ __CARD_HEADER_END__ ]]

--先史遺産モアイ
function c87430304.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_SPSUM_PARAM)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(POS_FACEUP_DEFENSE,0)
	e1:SetCondition(c87430304.hspcon)
	c:RegisterEffect(e1)
end
function c87430304.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x70)
end
function c87430304.hspcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c87430304.cfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
