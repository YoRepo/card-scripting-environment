--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Z-Metal Tank  (ID: 64500000)
-- Type: Monster / Effect / Union
-- Attribute: LIGHT
-- Race: Machine
-- Level: 4
-- ATK 1500 | DEF 1300
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, you can either: Target 1 "X-Head Cannon" or "Y-Dragon Head" you control; equip this
-- card to that target, OR: Unequip this card and Special Summon it.
-- A monster equipped with this card gains 600 ATK/DEF, also if the equipped monster would be destroyed
-- by battle or card effect, destroy this card instead.
--[[ __CARD_HEADER_END__ ]]

--Z－メタル・キャタピラー
function c64500000.initial_effect(c)
	aux.EnableUnionAttribute(c,c64500000.filter)
	--Atk up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(600)
	c:RegisterEffect(e3)
	--Def up
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	e4:SetValue(600)
	c:RegisterEffect(e4)
end
function c64500000.filter(c)
	return c:IsCode(62651957,65622692)
end
