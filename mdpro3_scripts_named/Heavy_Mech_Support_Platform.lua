--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Heavy Mech Support Platform  (ID: 23265594)
-- Type: Monster / Effect / Union
-- Attribute: DARK
-- Race: Machine
-- Level: 3
-- ATK 500 | DEF 500
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, you can either: Target 1 Machine monster you control; equip this card to that target,
-- OR: Unequip this card and Special Summon it.
-- A monster equipped with this card gains 500 ATK/DEF, also if the equipped monster would be destroyed
-- by battle or card effect, destroy this card instead.
--[[ __CARD_HEADER_END__ ]]

--強化支援メカ・ヘビーウェポン
function c23265594.initial_effect(c)
	aux.EnableUnionAttribute(c,c23265594.filter)
	--Atk up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(500)
	c:RegisterEffect(e3)
	--Def up
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	e4:SetValue(500)
	c:RegisterEffect(e4)
end
function c23265594.filter(c)
	return c:IsRace(RACE_MACHINE)
end
