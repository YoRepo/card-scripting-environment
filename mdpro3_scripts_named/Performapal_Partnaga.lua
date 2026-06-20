--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 娱乐伙伴 搭档蛇  (ID: 69211541)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Reptile
-- Level 5
-- Pendulum Scales: L3 / R3
-- ATK 500 | DEF 2100
-- Setcode: 159
--
-- Effect Text:
-- ←3 【灵摆】 3→
-- ①：1回合1次，以自己场上1只怪兽为对象才能发动。那只怪兽的攻击力直到回合结束时上升自己场上的「娱乐伙伴」卡数量×300。
-- 【怪兽效果】
-- ①：这张卡召唤·特殊召唤成功的场合，以自己场上1只怪兽为对象才能发动。那只怪兽的攻击力上升自己场上的「娱乐伙伴」怪兽数量×300。
-- ②：只要这张卡在怪兽区域存在，5星以下的怪兽不能攻击。
--[[ __CARD_HEADER_END__ ]]

--EMパートナーガ
function c69211541.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(69211541,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetTarget(c69211541.atktg)
	e2:SetOperation(c69211541.atkop1)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(69211541,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetTarget(c69211541.atktg)
	e3:SetOperation(c69211541.atkop2)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
	--cannot attack
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_CANNOT_ATTACK)
	e5:SetRange(LOCATION_MZONE)
	e5:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e5:SetTarget(aux.TargetBoolFunction(Card.IsLevelBelow,5))
	c:RegisterEffect(e5)
end
function c69211541.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end
function c69211541.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x9f)
end
function c69211541.atkop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	local ct=Duel.GetMatchingGroupCount(c69211541.filter,tp,LOCATION_ONFIELD,0,nil)
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(ct*300)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c69211541.atkop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local ct=Duel.GetMatchingGroupCount(c69211541.filter,tp,LOCATION_MZONE,0,nil)
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(ct*300)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
