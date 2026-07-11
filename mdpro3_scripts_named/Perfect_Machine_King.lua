--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Perfect Machine King  (ID: 18891691)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level: 8
-- ATK 2700 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card gains 500 ATK for each other Machine-Type monster on the field.
--[[ __CARD_HEADER_END__ ]]

--パーフェクト機械王
function c18891691.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c18891691.val)
	c:RegisterEffect(e1)
end
function c18891691.val(e,c)
	return Duel.GetMatchingGroupCount(c18891691.filter,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())*500
end
function c18891691.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE)
end
