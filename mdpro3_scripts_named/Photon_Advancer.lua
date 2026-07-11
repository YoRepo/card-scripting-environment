--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Photon Advancer  (ID: 98881931)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 4
-- ATK 1000 | DEF 1000
-- Setcode: 0x55
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a "Photon" monster is on the field, you can Special Summon this card (from your hand).
-- You can only Special Summon "Photon Advancer" once per turn this way.
-- Gains 1000 ATK if another "Photon" monster is on the field.
--[[ __CARD_HEADER_END__ ]]

--フォトン・アドバンサー
function c98881931.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,98881931+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c98881931.sprcon)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetCondition(c98881931.atkcon)
	e2:SetValue(1000)
	c:RegisterEffect(e2)
end
function c98881931.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x55)
end
function c98881931.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c98881931.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c98881931.valcon(e,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0 and re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
function c98881931.atkcon(e)
	return Duel.IsExistingMatchingCard(c98881931.filter,e:GetHandlerPlayer(),LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end
