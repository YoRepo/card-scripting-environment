--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Induced Explosion  (ID: 68077936)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a card(s) you control is destroyed by a Spell effect (except during the Damage Step): Target 1
-- card your opponent controls; destroy it.
-- During either player's turn, except the turn this card was sent to the Graveyard, when a card(s) you
-- control is destroyed by a Spell effect (except during the Damage Step): You can banish this card
-- from your Graveyard, then target 1 card your opponent controls; destroy it.
--[[ __CARD_HEADER_END__ ]]

--融爆
function c68077936.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c68077936.condition)
	e1:SetTarget(c68077936.target)
	e1:SetOperation(c68077936.activate)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c68077936.descon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c68077936.target)
	e2:SetOperation(c68077936.activate)
	c:RegisterEffect(e2)
end
function c68077936.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousControler(tp) and c:IsReason(REASON_EFFECT)
end
function c68077936.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c68077936.cfilter,1,nil,tp) and re and re:IsActiveType(TYPE_SPELL)
end
function c68077936.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c68077936.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c68077936.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c68077936.cfilter,1,nil,tp) and re and re:IsActiveType(TYPE_SPELL) and aux.exccon(e)
end
