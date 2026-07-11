--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Y-Dragon Head  (ID: 65622692)
-- Type: Monster / Effect / Union
-- Attribute: LIGHT
-- Race: Machine
-- Level: 4
-- ATK 1500 | DEF 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, you can either: Target 1 "X-Head Cannon" you control; equip this card to that target,
-- OR: Unequip this card and Special Summon it.
-- A monster equipped with this card gains 400 ATK/DEF, also if the equipped monster would be destroyed
-- by battle or card effect, destroy this card instead.
--[[ __CARD_HEADER_END__ ]]

--Y－ドラゴン・ヘッド
function c65622692.initial_effect(c)
	aux.EnableUnionAttribute(c,c65622692.filter)
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
function c65622692.filter(c)
	return c:IsCode(62651957)
end
