--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Storming Mirror Force  (ID: 5650082)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- When an opponent's monster declares an attack: Return all your opponent's Attack Position monsters
-- to the hand.
--[[ __CARD_HEADER_END__ ]]

--神風のバリア －エア・フォース－
function c5650082.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c5650082.condition)
	e1:SetTarget(c5650082.target)
	e1:SetOperation(c5650082.activate)
	c:RegisterEffect(e1)
end
function c5650082.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c5650082.filter(c)
	return c:IsAttackPos() and c:IsAbleToHand()
end
function c5650082.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c5650082.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c5650082.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c5650082.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c5650082.filter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end
