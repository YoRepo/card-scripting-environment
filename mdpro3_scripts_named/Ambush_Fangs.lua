--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 反击的毒牙  (ID: 77972406)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上表侧表示存在的名字带有「蛇毒」的怪兽受到攻击宣言时才能发动。把1只对方怪兽的攻击无效，战斗阶段结束。那之后，给攻击怪兽放置1个毒指示物。
--[[ __CARD_HEADER_END__ ]]

--反撃の毒牙
function c77972406.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c77972406.condition)
	e1:SetTarget(c77972406.target)
	e1:SetOperation(c77972406.activate)
	c:RegisterEffect(e1)
end
function c77972406.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttackTarget()
	return tc and tc:IsControler(tp) and tc:IsFaceup() and tc:IsSetCard(0x50)
end
function c77972406.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
end
function c77972406.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsRelateToEffect(e) and Duel.NegateAttack() then
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE_STEP,1)
		Duel.BreakEffect()
		local atk=tc:GetAttack()
		tc:AddCounter(0x1009,1)
		if atk>0 and tc:IsAttack(0) then
			Duel.RaiseEvent(tc,EVENT_CUSTOM+54306223,e,0,0,0,0)
		end
	end
end
