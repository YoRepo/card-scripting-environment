--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Remote Revenge  (ID: 61656650)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate only when a monster you control is targeted by a Spell, Trap or Effect Monster's effect
-- that destroys 1 monster on the field.
-- Switch the target to an appropriate monster your opponent controls.
--[[ __CARD_HEADER_END__ ]]

--悲劇の引き金
function c61656650.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c61656650.efcon)
	e1:SetTarget(c61656650.eftg)
	e1:SetOperation(c61656650.efop)
	c:RegisterEffect(e1)
end
function c61656650.efcon(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or g:GetCount()~=1 then return false end
	local tc=g:GetFirst()
	local ex,dg=Duel.GetOperationInfo(0,CATEGORY_DESTROY)
	return tc:IsControler(tp) and dg and dg:GetCount()==1 and dg:GetFirst()==tc and tc:IsType(TYPE_MONSTER)
end
function c61656650.filter(c,ct)
	return Duel.CheckChainTarget(ct,c)
end
function c61656650.eftg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c61656650.filter,tp,0,LOCATION_MZONE,1,nil,ev) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c61656650.filter,tp,0,LOCATION_MZONE,1,1,nil,ev)
end
function c61656650.efop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.CheckChainTarget(ev,tc) then
		local g=Group.FromCards(tc)
		Duel.ChangeTargetCard(ev,g)
	end
end
