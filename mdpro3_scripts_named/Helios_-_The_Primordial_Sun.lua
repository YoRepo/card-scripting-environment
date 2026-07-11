--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Helios - The Primordial Sun  (ID: 54493213)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Pyro
-- Level: 4
-- ATK ? | DEF ?
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card's ATK/DEF become the number of banished monsters x 100.
--[[ __CARD_HEADER_END__ ]]

--原始太陽ヘリオス
function c54493213.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetValue(c54493213.value)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_DEFENSE)
	c:RegisterEffect(e2)
end
function c54493213.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c54493213.value(e,c)
	return Duel.GetMatchingGroupCount(c54493213.filter,c:GetControler(),LOCATION_REMOVED,LOCATION_REMOVED,nil)*100
end
