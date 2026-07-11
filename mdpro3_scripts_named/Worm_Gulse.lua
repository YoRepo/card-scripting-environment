--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Worm Gulse  (ID: 85754829)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Reptile
-- Level: 4
-- ATK 1500 | DEF 300
-- Setcode: 0x3e
-- Scope: OCG / TCG
--
-- Effect Text:
-- Each time a face-down Defense Position monster is flipped face-up, place 1 Worm Counter on this
-- card.
-- This card gains 300 ATK for each Worm Counter on it.
--[[ __CARD_HEADER_END__ ]]

--ワーム・グルス
function c85754829.initial_effect(c)
	c:EnableCounterPermit(0xf)
	--add counter
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHANGE_POS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c85754829.accon)
	e1:SetOperation(c85754829.acop)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c85754829.atkval)
	c:RegisterEffect(e2)
end
function c85754829.atkval(e,c)
	return c:GetCounter(0xf)*300
end
function c85754829.cfilter(c)
	return c:IsPreviousPosition(POS_FACEDOWN) and c:IsFaceup()
end
function c85754829.accon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c85754829.cfilter,1,e:GetHandler())
end
function c85754829.acop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0xf,1)
end
