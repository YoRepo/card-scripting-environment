--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Torque Tune Gear  (ID: 79538761)
-- Type: Monster / Effect / Union / Tuner
-- Attribute: LIGHT
-- Race: Machine
-- Level: 1
-- ATK 0 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, you can either: Target 1 monster you control; equip this card to that target, OR:
-- Unequip this card and Special Summon it.
-- A monster equipped with this card is treated as a Tuner, it gains 500 ATK/DEF, also if the equipped
-- monster would be destroyed by battle or card effect, destroy this card instead.
--[[ __CARD_HEADER_END__ ]]

--トルクチューン・ギア
function c79538761.initial_effect(c)
	aux.EnableUnionAttribute(c,aux.TRUE)
	--add type
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_ADD_TYPE)
	e4:SetValue(TYPE_TUNER)
	c:RegisterEffect(e4)
	--atkup
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_UPDATE_ATTACK)
	e5:SetValue(500)
	c:RegisterEffect(e5)
	--defup
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_EQUIP)
	e6:SetCode(EFFECT_UPDATE_DEFENSE)
	e6:SetValue(500)
	c:RegisterEffect(e6)
end
