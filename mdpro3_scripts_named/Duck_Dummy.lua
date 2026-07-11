--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Duck Dummy  (ID: 43803845)
-- Type: Monster / Effect / Gemini
-- Attribute: WATER
-- Race: Winged Beast
-- Level: 1
-- ATK 0 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is treated as a Normal Monster while face-up on the field or in the GY.
-- While this card is a Normal Monster on the field, you can Normal Summon it to have it become an
-- Effect Monster with these effects.
-- ● Cannot be destroyed by card effects.
-- Neither player can target this card with card effects.
-- ● The attacks from your opponent's monsters become direct attacks.
--[[ __CARD_HEADER_END__ ]]

--ダックドロッパー
function c43803845.initial_effect(c)
	aux.EnableDualAttribute(c)
	--cannot be target/effect indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(aux.IsDualState)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	c:RegisterEffect(e2)
	--force direct
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetCondition(aux.IsDualState)
	e3:SetValue(c43803845.imval)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetProperty(0)
	e4:SetValue(0)
	c:RegisterEffect(e4)
	e3:SetLabelObject(e4)
end
function c43803845.imval(e,c)
	return not c:IsImmuneToEffect(e:GetLabelObject())
end
