--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Shine Knight  (ID: 86952477)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 3
-- ATK 400 | DEF 1900
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is Level 4 while in face-up Defense Position.
--[[ __CARD_HEADER_END__ ]]

--シャインナイト
function c86952477.initial_effect(c)
	--lvchange
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_LEVEL)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c86952477.lvcon)
	e1:SetValue(4)
	c:RegisterEffect(e1)
end
function c86952477.lvcon(e)
	return e:GetHandler():IsDefensePos()
end
