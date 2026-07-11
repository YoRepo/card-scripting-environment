--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Chronomaly Mud Golem  (ID: 67559101)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level: 4
-- ATK 1700 | DEF 1000
-- Setcode: 0x70
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a "Chronomaly" monster you control attacks a Defense Position monster, inflict piercing battle
-- damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--先史遺産マッドゴーレム・シャコウキ
function c67559101.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c67559101.target)
	c:RegisterEffect(e1)
end
function c67559101.target(e,c)
	return c:IsSetCard(0x70)
end
