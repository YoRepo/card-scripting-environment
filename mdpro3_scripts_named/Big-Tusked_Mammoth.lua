--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Big-Tusked Mammoth  (ID: 59380081)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level: 5
-- ATK 2000 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- Monsters your opponent controls cannot attack the turn they are Summoned.
--[[ __CARD_HEADER_END__ ]]

--ビッグホーン・マンモス
function c59380081.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetTarget(c59380081.target)
	c:RegisterEffect(e1)
end
function c59380081.target(e,c)
	return c:IsStatus(STATUS_SUMMON_TURN+STATUS_FLIP_SUMMON_TURN+STATUS_SPSUMMON_TURN)
end
