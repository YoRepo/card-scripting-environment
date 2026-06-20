--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 一半或停止  (ID: 15552258)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方回合的战斗阶段时才能发动。对方从以下效果选择1个适用。
-- ●直到战斗阶段结束时，自己场上存在的全部怪兽的攻击力变成一半数值。
-- ●把战斗阶段结束。
--[[ __CARD_HEADER_END__ ]]

--ハーフorストップ
function c15552258.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START)
	e1:SetCondition(c15552258.condition)
	e1:SetOperation(c15552258.activate)
	c:RegisterEffect(e1)
end
function c15552258.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE)
end
function c15552258.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	local opt=0
	if g:GetCount()==0 then
		opt=Duel.SelectOption(1-tp,aux.Stringid(15552258,1))+1
	else
		opt=Duel.SelectOption(1-tp,aux.Stringid(15552258,0),aux.Stringid(15552258,1))
	end
	if opt==1 then
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE_STEP,1)
		return
	end
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(math.ceil(tc:GetAttack()/2))
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
