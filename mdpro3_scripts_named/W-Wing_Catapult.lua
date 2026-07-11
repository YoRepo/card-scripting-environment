--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: W-Wing Catapult  (ID: 96300057)
-- Type: Monster / Effect / Union
-- Attribute: LIGHT
-- Race: Machine
-- Level: 4
-- ATK 1300 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, you can either: Target 1 "V-Tiger Jet" you control; equip this card to that target,
-- OR: Unequip this card and Special Summon it.
-- If the equipped monster would be destroyed by battle or card effect, destroy this card instead.
-- The equipped monster gains 400 ATK/DEF.
--[[ __CARD_HEADER_END__ ]]

--W－ウィング・カタパルト
function c96300057.initial_effect(c)
	aux.EnableUnionAttribute(c,c96300057.filter)
	--Atk up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(400)
	c:RegisterEffect(e3)
	--Def up
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	e4:SetValue(400)
	c:RegisterEffect(e4)
end
function c96300057.filter(c)
	return c:IsCode(51638941)
end
