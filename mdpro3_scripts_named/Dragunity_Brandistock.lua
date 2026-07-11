--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Dragunity Brandistock  (ID: 54455664)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Dragon
-- Level: 1
-- ATK 600 | DEF 400
-- Setcode: 0x29
-- Scope: OCG / TCG
--
-- Effect Text:
-- While this card is equipped to a monster, that monster can make a second attack during each Battle
-- Phase.
--[[ __CARD_HEADER_END__ ]]

--ドラグニティ－ブランディストック
function c54455664.initial_effect(c)
	--Double Attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
