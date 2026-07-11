--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Amazoness Queen  (ID: 15951532)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 6
-- ATK 2400 | DEF 1800
-- Setcode: 0x4
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Amazoness" monsters you control cannot be destroyed by battle.
--[[ __CARD_HEADER_END__ ]]

--アマゾネス女王
function c15951532.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x4))
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
