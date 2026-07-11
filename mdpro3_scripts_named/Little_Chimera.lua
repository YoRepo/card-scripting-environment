--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Little Chimera  (ID: 68658728)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Beast
-- Level: 2
-- ATK 600 | DEF 550
-- Scope: OCG / TCG
--
-- Effect Text:
-- All FIRE monsters on the field gain 500 ATK.
-- All WATER monsters on the field lose 400 ATK.
--[[ __CARD_HEADER_END__ ]]

--リトル・キメラ
function c68658728.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTarget(c68658728.tg1)
	e1:SetValue(500)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetTarget(c68658728.tg2)
	e2:SetValue(-400)
	c:RegisterEffect(e2)
end
function c68658728.tg1(e,c)
	return c:IsAttribute(ATTRIBUTE_FIRE)
end
function c68658728.tg2(e,c)
	return c:IsAttribute(ATTRIBUTE_WATER)
end
