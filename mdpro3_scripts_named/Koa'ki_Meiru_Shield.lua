--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Koa'ki Meiru Shield  (ID: 12216615)
-- Type: Trap
-- Setcode: 0x1d
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate only when your opponent's monster declares an attack if you have 2 or more "Iron Core of
-- Koa'ki Meiru" in your Graveyard.
-- Destroy all face-up Attack Position monsters your opponent controls.
--[[ __CARD_HEADER_END__ ]]

--コアキメイルの障壁
function c12216615.initial_effect(c)
	aux.AddCodeList(c,36623431)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c12216615.condition)
	e1:SetTarget(c12216615.target)
	e1:SetOperation(c12216615.activate)
	c:RegisterEffect(e1)
end
function c12216615.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,2,nil,36623431)
end
function c12216615.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK)
end
function c12216615.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c12216615.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c12216615.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c12216615.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c12216615.filter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
