--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Blindly Loyal Goblin  (ID: 35215622)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 4
-- ATK 1800 | DEF 1500
-- Setcode: 0xac
-- Scope: OCG / TCG
--
-- Effect Text:
-- As long as this card remains face-up on the field, control of this card cannot switch.
--[[ __CARD_HEADER_END__ ]]

--盲信するゴブリン
function c35215622.initial_effect(c)
	--control
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e1)
end
