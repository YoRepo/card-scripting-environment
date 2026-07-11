--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Number Wall  (ID: 847915)
-- Type: Trap / Continuous
-- Setcode: 0x16a
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate only if you control a "Number" monster. "Number" monsters on the field cannot be destroyed
-- by card effects, and cannot be destroyed by battle except with another "Number" monster.
-- When a "Number" monster you control is destroyed, destroy this card.
--[[ __CARD_HEADER_END__ ]]

--ナンバーズ・ウォール
function c847915.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c847915.actcon)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x48))
	e2:SetValue(c847915.indval)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x48))
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetCondition(c847915.descon)
	e4:SetOperation(c847915.desop)
	c:RegisterEffect(e4)
end
function c847915.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x48)
end
function c847915.indval(e,c)
	return not c:IsSetCard(0x48)
end
function c847915.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c847915.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c847915.dfilter(c,tp)
	return c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousSetCard(0x48)
end
function c847915.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c847915.dfilter,1,nil,tp)
end
function c847915.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
