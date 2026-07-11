--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Enraged Battle Ox  (ID: 76909279)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level: 4
-- ATK 1700 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your Beast, Beast-Warrior, or Winged Beast monster attacks a Defense Position monster, inflict
-- piercing battle damage.
--[[ __CARD_HEADER_END__ ]]

--激昂のミノタウルス
function c76909279.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c76909279.target)
	c:RegisterEffect(e1)
end
function c76909279.target(e,c)
	return c:IsRace(RACE_BEASTWARRIOR+RACE_WINDBEAST+RACE_BEAST)
end
