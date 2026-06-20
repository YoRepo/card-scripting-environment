--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 护卫防壁  (ID: 24268052)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方回合的战斗伤害计算时才能发动。那次战斗发生的对自己的战斗伤害变成0，从自己卡组抽1张卡。
--[[ __CARD_HEADER_END__ ]]

--ガード・ブロック
function c24268052.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c24268052.condition)
	e1:SetTarget(c24268052.target)
	e1:SetOperation(c24268052.operation)
	c:RegisterEffect(e1)
end
function c24268052.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetBattleDamage(tp)>0
end
function c24268052.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c24268052.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
	Duel.Draw(tp,1,REASON_EFFECT)
end
