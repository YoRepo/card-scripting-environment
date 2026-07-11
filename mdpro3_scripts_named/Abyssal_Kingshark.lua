--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Abyssal Kingshark  (ID: 44223284)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level: 4
-- ATK 1700 | DEF 600
-- Setcode: 0x1b8
-- Scope: OCG / TCG
--
-- Effect Text:
-- Each turn, the first time this card would be destroyed by an effect that does not target it, it is
-- not destroyed.
--[[ __CARD_HEADER_END__ ]]

--深海王デビルシャーク
function c44223284.initial_effect(c)
	--battle indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetValue(c44223284.valcon)
	c:RegisterEffect(e1)
end
function c44223284.valcon(e,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0 and not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET)
end
