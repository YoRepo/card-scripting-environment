--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 龙骑兵团骑士-魔枪龙骑士  (ID: 900787)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Dragon
-- Level 6
-- ATK 2000 | DEF 1100
-- Setcode: 41
--
-- Effect Text:
-- 龙族调整＋调整以外的鸟兽族怪兽1只以上
-- ①：这张卡进行战斗的从伤害步骤开始时到伤害计算前1次，从自己墓地把1只鸟兽族怪兽除外才能发动。这张卡的攻击力直到回合结束时上升除外的那只怪兽的原本攻击力数值。
--[[ __CARD_HEADER_END__ ]]

--ドラグニティナイト－ゲイボルグ
function c900787.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_DRAGON),aux.NonTuner(Card.IsRace,RACE_WINDBEAST),1)
	c:EnableReviveLimit()
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(900787,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c900787.condition)
	e1:SetCost(c900787.cost)
	e1:SetOperation(c900787.operation)
	c:RegisterEffect(e1)
end
function c900787.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ph=Duel.GetCurrentPhase()
	return ph==PHASE_DAMAGE and (c==Duel.GetAttacker() or c==Duel.GetAttackTarget())
		and not Duel.IsDamageCalculated()
end
function c900787.cfilter(c)
	return c:IsRace(RACE_WINDBEAST) and c:IsAbleToRemoveAsCost()
end
function c900787.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(900787)==0
		and Duel.IsExistingMatchingCard(c900787.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c900787.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	e:SetLabel(g:GetFirst():GetAttack())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	e:GetHandler():RegisterFlagEffect(900787,RESET_PHASE+PHASE_DAMAGE,0,1)
end
function c900787.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
