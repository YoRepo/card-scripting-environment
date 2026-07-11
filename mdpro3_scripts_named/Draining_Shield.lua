--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Draining Shield  (ID: 43250041)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- If an opponent's monster declares an attack: Target the attacking monster; negate that attack, and
-- if you do, gain LP equal to that target's ATK.
--[[ __CARD_HEADER_END__ ]]

--ドレインシールド
function c43250041.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c43250041.condition)
	e1:SetTarget(c43250041.target)
	e1:SetOperation(c43250041.activate)
	c:RegisterEffect(e1)
end
function c43250041.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c43250041.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
	local rec=tg:GetAttack()
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,rec)
end
function c43250041.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsAttackable() then
		if Duel.NegateAttack() then
			Duel.Recover(tp,tc:GetAttack(),REASON_EFFECT)
		end
	end
end
