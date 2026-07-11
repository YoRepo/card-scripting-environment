--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Dark Resonator  (ID: 97021916)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Fiend
-- Level: 3
-- ATK 1300 | DEF 300
-- Setcode: 0x57
-- Scope: OCG / TCG
--
-- Effect Text:
-- The first time this card would be destroyed by battle each turn, it is not destroyed.
--[[ __CARD_HEADER_END__ ]]

--ダーク・リゾネーター
function c97021916.initial_effect(c)
	--battle indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetValue(c97021916.valcon)
	c:RegisterEffect(e1)
end
function c97021916.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
