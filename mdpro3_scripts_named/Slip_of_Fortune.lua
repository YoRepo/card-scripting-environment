--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Slip of Fortune  (ID: 72885174)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate only when your opponent's monster declares an attack targeting a monster.
-- Negate the attack and remove from play the attack target monster until the next Standby Phase.
--[[ __CARD_HEADER_END__ ]]

--フォーチュン・スリップ
function c72885174.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c72885174.condition)
	e1:SetTarget(c72885174.target)
	e1:SetOperation(c72885174.activate)
	c:RegisterEffect(e1)
end
function c72885174.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.GetAttackTarget()
end
function c72885174.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if chk==0 then return a:IsOnField() and a:IsCanBeEffectTarget(e)
		and d:IsOnField() and d:IsAbleToRemove() and d:IsCanBeEffectTarget(e) end
	local g=Group.FromCards(a,d)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,d,1,0,0)
end
function c72885174.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	local a=Duel.GetAttacker()
	local tc=Duel.GetAttackTarget()
	if a:IsRelateToEffect(e) and a:IsFaceup() and tc:IsRelateToEffect(e) and Duel.Remove(tc,0,REASON_EFFECT+REASON_TEMPORARY)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e1:SetReset(RESET_PHASE+PHASE_STANDBY)
		e1:SetLabelObject(tc)
		e1:SetCountLimit(1)
		e1:SetOperation(c72885174.retop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c72885174.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ReturnToField(e:GetLabelObject())
end
