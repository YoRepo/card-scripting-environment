--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Queen's Bodyguard  (ID: 71411377)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 4
-- ATK 1700 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Allure Queen" monsters on your side of the field cannot be selected as an attack target.
--[[ __CARD_HEADER_END__ ]]

--女王親衛隊
function c71411377.initial_effect(c)
	--at limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetTarget(c71411377.atlimit)
	e1:SetValue(aux.imval1)
	c:RegisterEffect(e1)
end
function c71411377.atlimit(e,c)
	return c:IsSetCard(0x3)
end
