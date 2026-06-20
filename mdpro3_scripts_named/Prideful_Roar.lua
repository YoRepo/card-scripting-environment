--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 自尊的咆哮  (ID: 66518841)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 战斗伤害计算时，自己怪兽的攻击力比对方怪兽低的场合，支付那个攻击力差的数值的基本分发动。只在伤害计算时，自己怪兽的攻击力上升和对方怪兽的攻击力差的数值＋300。
--[[ __CARD_HEADER_END__ ]]

--プライドの咆哮
function c66518841.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c66518841.condition)
	e1:SetCost(c66518841.cost)
	e1:SetOperation(c66518841.activate)
	c:RegisterEffect(e1)
end
function c66518841.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsControler(1-tp) then tc=Duel.GetAttackTarget() end
	if not tc then return false end
	local bc=tc:GetBattleTarget()
	if tc and bc then
		local dif=bc:GetAttack()-tc:GetAttack()
		e:SetLabel(dif)
		return dif>0
	else return false end
end
function c66518841.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,e:GetLabel()) end
	Duel.PayLPCost(tp,e:GetLabel())
end
function c66518841.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsControler(1-tp) then tc=Duel.GetAttackTarget() end
	local bc=tc:GetBattleTarget()
	local dif=bc:GetAttack()-tc:GetAttack()
	if dif>0 and tc:IsRelateToBattle() and bc:IsRelateToBattle() and tc:IsFaceup() and bc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(dif+300)
		tc:RegisterEffect(e1)
	end
end
