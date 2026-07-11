--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: D.3.S. Frog  (ID: 9910360)
-- Type: Monster / Effect / Fusion
-- Attribute: WATER
-- Race: Aqua
-- Level: 8
-- ATK 2500 | DEF 2000
-- Setcode: 0x12
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Des Frog" + "Des Frog" + "Des Frog"
-- A Fusion Summon of this card can only be conducted with the above Fusion Material Monsters.
-- This card gains 500 ATK for each "Treeborn Frog" in your Graveyard.
--[[ __CARD_HEADER_END__ ]]

--ガエル・サンデス
function c9910360.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,84451804,3,false,false)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c9910360.atkval)
	c:RegisterEffect(e2)
end
function c9910360.atkval(e,c)
	return Duel.GetMatchingGroupCount(Card.IsCode,c:GetControler(),LOCATION_GRAVE,0,nil,12538374)*500
end
