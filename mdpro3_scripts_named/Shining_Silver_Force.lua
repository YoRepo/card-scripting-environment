--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Shining Silver Force  (ID: 89563150)
-- Type: Trap / Counter
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate only when your opponent activates a Trap Card that inflicts damage.
-- Negate the activation of that card and destroy it and all face-up Spell and Trap Cards your opponent
-- controls.
--[[ __CARD_HEADER_END__ ]]

--白銀のバリア－シルバーフォース－
function c89563150.initial_effect(c)
	--Negate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c89563150.discon)
	e1:SetTarget(c89563150.distg)
	e1:SetOperation(c89563150.disop)
	c:RegisterEffect(e1)
end
function c89563150.discon(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp or not re:IsHasType(EFFECT_TYPE_ACTIVATE) or not re:IsActiveType(TYPE_TRAP) or not Duel.IsChainNegatable(ev) then return false end
	local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
	if ex then return true end
	ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_RECOVER)
	return ex and ((cp~=PLAYER_ALL and Duel.IsPlayerAffectedByEffect(cp,EFFECT_REVERSE_RECOVER)) or
		(cp==PLAYER_ALL and (Duel.IsPlayerAffectedByEffect(0,EFFECT_REVERSE_RECOVER) or Duel.IsPlayerAffectedByEffect(1,EFFECT_REVERSE_RECOVER))))
end
function c89563150.dfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c89563150.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	local g=Duel.GetMatchingGroup(c89563150.dfilter,tp,0,LOCATION_ONFIELD,nil)
	if re:GetHandler():IsRelateToEffect(re) then
		g:Merge(eg)
	end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c89563150.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) then
		local g=Duel.GetMatchingGroup(c89563150.dfilter,tp,0,LOCATION_ONFIELD,nil)
		if re:GetHandler():IsRelateToEffect(re) then
			g:Merge(eg)
		end
		Duel.Destroy(g,REASON_EFFECT)
	end
end
