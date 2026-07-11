--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Phantom Beast Cross-Wing  (ID: 71181155)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast-Warrior
-- Level: 4
-- ATK 1300 | DEF 1300
-- Setcode: 0x1b
-- Scope: OCG / TCG
--
-- Effect Text:
-- While this card is in the GY, all "Phantom Beast" monsters on the field gain 300 ATK.
--[[ __CARD_HEADER_END__ ]]

--幻獣クロスウィング
function c71181155.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x1b))
	e1:SetValue(300)
	c:RegisterEffect(e1)
end
