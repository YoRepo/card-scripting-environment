--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Destruction Punch  (ID: 5616412)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- If the ATK of an attacking monster your opponent controls is lower than the DEF of the attacked
-- Defense Position monster you control, destroy the attacking monster at the end of the Damage Step.
-- (Damage calculation is applied normally.)
--[[ __CARD_HEADER_END__ ]]

--カウンターパンチ
function c5616412.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCondition(c5616412.condition)
	e1:SetTarget(c5616412.target)
	e1:SetOperation(c5616412.activate)
	c:RegisterEffect(e1)
end
function c5616412.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d and a:IsControler(1-tp) and a:IsRelateToBattle()
		and d:IsDefensePos() and d:IsRelateToBattle() and d:GetDefense()>a:GetAttack()
end
function c5616412.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(Duel.GetAttacker())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,Duel.GetAttacker(),1,0,0)
end
function c5616412.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
