--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Aroma Jar  (ID: 21452275)
-- Type: Monster / Effect / Flip
-- Attribute: WIND
-- Race: Rock
-- Level: 1
-- ATK 500 | DEF 400
-- Setcode: 0xc9
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is flipped face-up, this card cannot be destroyed by battle while it is face-up on the
-- field.
-- If this card is flipped face-up, during each End Phase: You gain 500 LP.
--[[ __CARD_HEADER_END__ ]]

--アロマポット
function c21452275.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_FLIP)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetOperation(c21452275.flipop)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetCondition(c21452275.indcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--Recover
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_RECOVER)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCountLimit(1)
	e3:SetCondition(c21452275.reccon)
	e3:SetTarget(c21452275.rectg)
	e3:SetOperation(c21452275.recop)
	c:RegisterEffect(e3)
end
function c21452275.flipop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(21452275,RESET_EVENT+RESETS_STANDARD,0,1)
end
function c21452275.indcon(e)
	return e:GetHandler():GetFlagEffect(21452275)~=0
end
function c21452275.reccon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(21452275)~=0
end
function c21452275.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(500)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,500)
end
function c21452275.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
