--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Pumpkin Carriage  (ID: 14512825)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level: 3
-- ATK 0 | DEF 300
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Prinzessin" you control can attack directly.
-- Your opponent cannot target "Golden Castle of Stromberg" you control with card effects, also it
-- cannot be destroyed by card effects.
--[[ __CARD_HEADER_END__ ]]

--カボチャの馬車
function c14512825.initial_effect(c)
	aux.AddCodeList(c,72283691)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsCode,78527720))
	c:RegisterEffect(e1)
	--indes/untarget
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_ONFIELD,0)
	e2:SetTarget(c14512825.indtg)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c14512825.indtg(e,c)
	return c:IsFaceup() and c:IsCode(72283691)
end
