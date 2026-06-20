--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 闪光弹  (ID: 9267769)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方场上的怪兽直接攻击成功时才能发动。变成这个回合的结束阶段。
--[[ __CARD_HEADER_END__ ]]

--閃光弾
function c9267769.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c9267769.condition)
	e1:SetOperation(c9267769.activate)
	c:RegisterEffect(e1)
end
function c9267769.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetFirst():IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c9267769.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_END,1,1)
	Duel.SkipPhase(1-tp,PHASE_MAIN2,RESET_PHASE+PHASE_END,1)
end
