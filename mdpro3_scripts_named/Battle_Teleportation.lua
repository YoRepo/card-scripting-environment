--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 战斗瞬间移动  (ID: 71652522)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上表侧表示存在的念动力族怪兽只有1只的场合，选择那1只怪兽发动。这个回合选择怪兽可以直接攻击对方玩家。这个回合的战斗阶段结束时，选择怪兽的控制权转移给对方。
--[[ __CARD_HEADER_END__ ]]

--バトル・テレポーテーション
function c71652522.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c71652522.condition)
	e1:SetTarget(c71652522.target)
	e1:SetOperation(c71652522.activate)
	c:RegisterEffect(e1)
end
function c71652522.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()<=PHASE_BATTLE
end
function c71652522.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_PSYCHO)
end
function c71652522.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.GetMatchingGroupCount(c71652522.filter,tp,LOCATION_MZONE,0,nil)==1 end
	local tc=Duel.GetMatchingGroup(c71652522.filter,tp,LOCATION_MZONE,0,nil):GetFirst()
	Duel.SetTargetCard(tc)
end
function c71652522.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DIRECT_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
		e2:SetCountLimit(1)
		e2:SetReset(RESET_PHASE+PHASE_BATTLE)
		e2:SetOperation(c71652522.ctop)
		e2:SetLabelObject(tc)
		Duel.RegisterEffect(e2,tp)
		tc:RegisterFlagEffect(71652522,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_PHASE+PHASE_BATTLE,0,1)
	end
end
function c71652522.ctop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:GetFlagEffect(71652522)~=0 then
		Duel.GetControl(tc,1-tp)
	end
end
