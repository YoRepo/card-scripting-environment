--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Botanical Lion  (ID: 20546916)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level: 4
-- ATK 1600 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card gains 300 ATK for each Plant-Type monster you control.
-- Control of this face-up card on the field cannot switch.
--[[ __CARD_HEADER_END__ ]]

--ボタニカル・ライオ
function c20546916.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c20546916.val)
	c:RegisterEffect(e1)
	--control
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e2)
end
function c20546916.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_PLANT)
end
function c20546916.val(e,c)
	return Duel.GetMatchingGroupCount(c20546916.filter,c:GetControler(),LOCATION_MZONE,0,nil)*300
end
