--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Karakuri Cash Shed  (ID: 2924048)
-- Type: Trap / Counter
-- Setcode: 0x11
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate only if you control a "Karakuri" monster in face-up Defense Position.
-- Negate the activation of an opponent's Spell/Trap Card and destroy it.
--[[ __CARD_HEADER_END__ ]]

--借カラクリ整備蔵
function c2924048.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c2924048.condition)
	e1:SetTarget(c2924048.target)
	e1:SetOperation(c2924048.activate)
	c:RegisterEffect(e1)
end
function c2924048.cfilter(c)
	return c:IsPosition(POS_FACEUP_DEFENSE) and c:IsSetCard(0x11)
end
function c2924048.condition(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp or not Duel.IsExistingMatchingCard(c2924048.cfilter,tp,LOCATION_MZONE,0,1,nil) then return false end
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c2924048.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c2924048.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
