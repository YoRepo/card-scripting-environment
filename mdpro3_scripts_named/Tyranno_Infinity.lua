--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Tyranno Infinity  (ID: 83235263)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dinosaur
-- Level: 4
-- ATK ? | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- The original ATK of this card becomes the number of your banished Dinosaur monsters x 1000.
--[[ __CARD_HEADER_END__ ]]

--ディノインフィニティ
function c83235263.initial_effect(c)
	--base attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c83235263.atkval)
	c:RegisterEffect(e1)
end
function c83235263.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_DINOSAUR)
end
function c83235263.atkval(e,c)
	return Duel.GetMatchingGroupCount(c83235263.filter,c:GetControler(),LOCATION_REMOVED,0,nil)*1000
end
