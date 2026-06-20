--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 娱乐伙伴 小判龙  (ID: 9000988)
-- Type: Monster / Effect / Pendulum
-- Attribute: WATER
-- Race: Dragon
-- Level 4
-- Pendulum Scales: L5 / R5
-- ATK 1700 | DEF 1000
-- Setcode: 159
--
-- Effect Text:
-- ←5 【灵摆】 5→
-- ①：1回合1次，以从额外卡组特殊召唤的自己场上1只龙族怪兽为对象才能发动。这个回合，那只自己怪兽和对方怪兽进行战斗的场合，那只对方怪兽在伤害计算后除外。
-- 【怪兽效果】
-- ①：只要这张卡在怪兽区域存在，这张卡以外的自己场上的龙族怪兽攻击力上升500，不会被效果破坏。
--[[ __CARD_HEADER_END__ ]]

--EM小判竜
function c9000988.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9000988,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c9000988.condition)
	e1:SetTarget(c9000988.target)
	e1:SetOperation(c9000988.operation)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c9000988.atktg)
	e2:SetValue(500)
	c:RegisterEffect(e2)
	--indes
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c9000988.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c9000988.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON) and c:IsSummonLocation(LOCATION_EXTRA)
end
function c9000988.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c9000988.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c9000988.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c9000988.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c9000988.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_BATTLED)
		e1:SetOwnerPlayer(tp)
		e1:SetCondition(c9000988.rmcon)
		e1:SetOperation(c9000988.rmop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1,true)
	end
end
function c9000988.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	return tp==e:GetOwnerPlayer() and tc and tc:IsControler(1-tp)
end
function c9000988.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end
function c9000988.atktg(e,c)
	return c:IsRace(RACE_DRAGON) and c~=e:GetHandler()
end
