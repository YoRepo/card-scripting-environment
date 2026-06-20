--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 异次元隧道-镜之门-  (ID: 43452193)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上表侧表示存在的名字带有「元素英雄」的怪兽为攻击对象的对方怪兽攻击宣言时才能发动。对方的攻击怪兽和成为攻击对象的自己怪兽交换控制权进行伤害计算。直到这个回合结束阶段时得到控制权交换怪兽的控制权。
--[[ __CARD_HEADER_END__ ]]

--異次元トンネル－ミラーゲート－
function c43452193.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c43452193.condition)
	e1:SetTarget(c43452193.target)
	e1:SetOperation(c43452193.activate)
	c:RegisterEffect(e1)
end
function c43452193.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return Duel.GetTurnPlayer()~=tp and at and at:IsFaceup() and at:IsSetCard(0x3008)
end
function c43452193.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	if chk==0 then return a:IsOnField() and a:IsAbleToChangeControler() and Duel.GetMZoneCount(1-tp,a,1-tp,LOCATION_REASON_CONTROL)>0
		and at:IsOnField() and at:IsAbleToChangeControler() and Duel.GetMZoneCount(tp,at,tp,LOCATION_REASON_CONTROL)>0 end
	local g=Group.FromCards(a,at)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,2,0,0)
end
function c43452193.activate(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	if a:IsRelateToEffect(e) and a:IsAttackable() and at:IsRelateToEffect(e) then
		if Duel.SwapControl(a,at,RESET_PHASE+PHASE_END,1) then
			Duel.CalculateDamage(a,at)
		end
	end
end
