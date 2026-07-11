--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Vylon Charger  (ID: 13220032)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 4
-- ATK 1000 | DEF 1000
-- Setcode: 0x30
-- Scope: OCG / TCG
--
-- Effect Text:
-- All face-up LIGHT monsters you control gain 300 ATK for each Equip Card equipped to this card.
--[[ __CARD_HEADER_END__ ]]

--ヴァイロン・チャージャー
function c13220032.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsAttribute,ATTRIBUTE_LIGHT))
	e1:SetValue(c13220032.atkval)
	c:RegisterEffect(e1)
end
function c13220032.atkval(e,c)
	return e:GetHandler():GetEquipCount()*300
end
