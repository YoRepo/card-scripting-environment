--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Powered Tuner  (ID: 50621530)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Dragon
-- Level: 4
-- ATK 1400 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card gains 500 ATK for each face-up Tuner monster on the field.
--[[ __CARD_HEADER_END__ ]]

--パワード・チューナー
function c50621530.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c50621530.atkval)
	c:RegisterEffect(e1)
end
function c50621530.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_TUNER)
end
function c50621530.atkval(e,c)
	return Duel.GetMatchingGroupCount(c50621530.cfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)*500
end
