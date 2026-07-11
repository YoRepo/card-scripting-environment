--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Tenshin  (ID: 59563768)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 2
-- ATK 800 | DEF 100
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card gains 400 ATK for each face-up Level 2 monster you control.
--[[ __CARD_HEADER_END__ ]]

--転身テンシーン
function c59563768.initial_effect(c)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c59563768.atkval)
	c:RegisterEffect(e2)
end
function c59563768.filter(c)
	return c:IsFaceup() and c:IsLevel(2)
end
function c59563768.atkval(e,c)
	return Duel.GetMatchingGroupCount(c59563768.filter,e:GetHandlerPlayer(),LOCATION_MZONE,0,nil)*400
end
