--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Rage of the Deep Sea  (ID: 73778008)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level: 5
-- ATK 0 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card gains 500 ATK and DEF for each Fish, Sea Serpent, or Aqua-Type monster in your Graveyard.
--[[ __CARD_HEADER_END__ ]]

--深海の怒り
function c73778008.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c73778008.atkup)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
end
function c73778008.atkup(e,c)
	return Duel.GetMatchingGroupCount(Card.IsRace,c:GetControler(),LOCATION_GRAVE,0,nil,RACE_FISH+RACE_SEASERPENT+RACE_AQUA)*500
end
