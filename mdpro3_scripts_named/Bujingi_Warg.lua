--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Bujingi Warg  (ID: 80555062)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast
-- Level: 4
-- ATK 1200 | DEF 1900
-- Setcode: 0x88
-- Scope: OCG / TCG
--
-- Effect Text:
-- While this card is in face-up Defense Position, other "Bujin" monsters you control cannot be
-- destroyed by card effects.
--[[ __CARD_HEADER_END__ ]]

--武神器－チカヘシ
function c80555062.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c80555062.target)
	e1:SetCondition(c80555062.con)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
function c80555062.con(e)
	return e:GetHandler():IsDefensePos()
end
function c80555062.target(e,c)
	return c~=e:GetHandler() and c:IsSetCard(0x88)
end
