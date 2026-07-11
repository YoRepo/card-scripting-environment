--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Bending Destiny  (ID: 94662235)
-- Type: Trap / Counter
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a monster(s) would be Normal Summoned, OR a Spell/Trap Card is activated, while all face-up
-- monsters you control are "Fortune Lady" monsters (min. 1): Negate the Summon or activation, and if
-- you do, banish that card.
-- That banished card is returned to the hand during the End Phase of this turn.
--[[ __CARD_HEADER_END__ ]]

--運命湾曲
function c94662235.initial_effect(c)
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON)
	e1:SetCondition(c94662235.condition1)
	e1:SetTarget(c94662235.target1)
	e1:SetOperation(c94662235.activate1)
	c:RegisterEffect(e1)
	--Activate(effect)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(c94662235.condition2)
	e2:SetTarget(aux.nbtg)
	e2:SetOperation(c94662235.activate2)
	c:RegisterEffect(e2)
end
function c94662235.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x31)
end
function c94662235.check(tp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
	return g:IsExists(c94662235.cfilter,1,nil)
		and not g:IsExists(aux.NOT(c94662235.cfilter),1,nil)
end
function c94662235.condition1(e,tp,eg,ep,ev,re,r,rp)
	return aux.NegateSummonCondition() and c94662235.check(tp)
end
function c94662235.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:GetFirst():IsAbleToRemove() end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,1,0,0)
end
function c94662235.activate1(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg:GetFirst())
	local ec=eg:GetFirst()
	if Duel.Remove(ec,POS_FACEUP,REASON_EFFECT)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetCountLimit(1)
		e1:SetLabelObject(ec)
		e1:SetCondition(c94662235.retcon)
		e1:SetOperation(c94662235.retop)
		Duel.RegisterEffect(e1,tp)
		ec:RegisterFlagEffect(94662235,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
	end
end
function c94662235.condition2(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev) and c94662235.check(tp)
end
function c94662235.activate2(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	if Duel.NegateActivation(ev) and ec:IsRelateToEffect(re) then
		if Duel.Remove(ec,POS_FACEUP,REASON_EFFECT)~=0 then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_PHASE+PHASE_END)
			e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetCountLimit(1)
			e1:SetLabelObject(ec)
			e1:SetCondition(c94662235.retcon)
			e1:SetOperation(c94662235.retop)
			Duel.RegisterEffect(e1,tp)
			ec:RegisterFlagEffect(94662235,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
		end
	end
end
function c94662235.retcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return tc:GetFlagEffect(94662235)~=0
end
function c94662235.retop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.SendtoHand(tc,nil,REASON_EFFECT)
end
