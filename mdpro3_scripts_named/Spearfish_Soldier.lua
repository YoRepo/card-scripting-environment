--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Spearfish Soldier  (ID: 84569017)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Sea Serpent
-- Level: 4
-- ATK 1700 | DEF 1100
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card gains 100 ATK for each of your banished Fish, Sea Serpent, and Aqua-Type monsters.
--[[ __CARD_HEADER_END__ ]]

--スピアフィッシュソルジャー
function c84569017.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c84569017.atkup)
	c:RegisterEffect(e1)
end
function c84569017.atkfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_FISH+RACE_AQUA+RACE_SEASERPENT)
end
function c84569017.atkup(e,c)
	return Duel.GetMatchingGroupCount(c84569017.atkfilter,c:GetControler(),LOCATION_REMOVED,0,nil)*100
end
