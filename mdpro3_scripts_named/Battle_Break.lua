--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Battle Break  (ID: 22047978)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- When an opponent's monster declares an attack: Your opponent can reveal 1 monster in their hand to
-- negate this card's effect, otherwise destroy the attacking monster, then end the Battle Phase.
--[[ __CARD_HEADER_END__ ]]

--バトル・ブレイク
function c22047978.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c22047978.condition)
	e1:SetTarget(c22047978.target)
	e1:SetOperation(c22047978.activate)
	c:RegisterEffect(e1)
end
function c22047978.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c22047978.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetAttacker()
	if chk==0 then return tg:IsOnField() end
	Duel.SetTargetCard(tg)
	if Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)==0 then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,1,0,0)
	end
end
function c22047978.cfilter(c)
	return not c:IsPublic() and c:IsType(TYPE_MONSTER)
end
function c22047978.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsChainDisablable(0) then
		local sel=1
		local g=Duel.GetMatchingGroup(c22047978.cfilter,1-tp,LOCATION_HAND,0,nil)
		Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(22047978,0))
		if g:GetCount()>0 then
			sel=Duel.SelectOption(1-tp,1213,1214)
		else
			sel=Duel.SelectOption(1-tp,1214)+1
		end
		if sel==0 then
			Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_CONFIRM)
			local cg=g:Select(1-tp,1,1,nil)
			Duel.ConfirmCards(tp,cg)
			Duel.ShuffleHand(1-tp)
			Duel.NegateEffect(0)
			return
		end
	end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsAttackable() and not tc:IsStatus(STATUS_ATTACK_CANCELED)
		and Duel.Destroy(tc,REASON_EFFECT)>0 then
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE_STEP,1)
	end
end
