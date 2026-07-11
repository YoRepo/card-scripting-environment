--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Gogogo Golem  (ID: 62476815)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level: 4
-- ATK 1800 | DEF 1500
-- Setcode: 0x59
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, this Defense Position card cannot be destroyed by battle.
--[[ __CARD_HEADER_END__ ]]

--ゴゴゴゴーレム
function c62476815.initial_effect(c)
	--battle indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetValue(c62476815.valcon)
	c:RegisterEffect(e1)
end
function c62476815.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0 and e:GetHandler():IsDefensePos()
end
