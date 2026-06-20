--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: D-幸运  (ID: 9201964)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方宣言直接攻击时才能发动。把自己墓地存在的1只名字带有「命运英雄」的怪兽从游戏中除外，战斗阶段结束。
--[[ __CARD_HEADER_END__ ]]

--D－フォーチュン
function c9201964.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c9201964.condition)
	e1:SetCost(c9201964.cost)
	e1:SetOperation(c9201964.activate)
	c:RegisterEffect(e1)
end
function c9201964.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.GetAttackTarget()==nil
end
function c9201964.cfilter(c)
	return c:IsSetCard(0xc008) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c9201964.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c9201964.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c9201964.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c9201964.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE_STEP,1)
end
