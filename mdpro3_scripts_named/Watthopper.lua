--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Watthopper  (ID: 61380658)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level: 1
-- ATK 0 | DEF 0
-- Setcode: 0xe
-- Scope: OCG / TCG
--
-- Effect Text:
-- Your opponent's monsters cannot target "Watt" monster for an attack, except this one, also your
-- opponent cannot target them with card effects.
--[[ __CARD_HEADER_END__ ]]

--エレキリギリス
function c61380658.initial_effect(c)
	--untargetable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c61380658.atlimit)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c61380658.tglimit)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
end
function c61380658.atlimit(e,c)
	return c:IsFaceup() and c:IsSetCard(0xe) and c~=e:GetHandler()
end
function c61380658.tglimit(e,c)
	return c:IsSetCard(0xe) and c~=e:GetHandler()
end
