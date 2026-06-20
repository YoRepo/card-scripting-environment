--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 娱乐伙伴 降落驼  (ID: 44481227)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Beast
-- Level 4
-- Pendulum Scales: L2 / R2
-- ATK 800 | DEF 1800
-- Setcode: 159
--
-- Effect Text:
-- ←2 【灵摆】 2→
-- ①：1回合1次，以自己场上1只表侧表示怪兽为对象才能发动。对方场上的全部怪兽的守备力直到回合结束时下降800，这个回合作为对象的怪兽向守备表示怪兽攻击的场合，给与对方为攻击力超过那个守备力的数值的战斗
-- 伤害。
-- 【怪兽效果】
-- ①：这张卡被战斗破坏的场合才能发动。让把这张卡破坏的怪兽的攻击力下降800。
--[[ __CARD_HEADER_END__ ]]

--EMラクダウン
function c44481227.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCondition(c44481227.condition)
	e2:SetTarget(c44481227.target)
	e2:SetOperation(c44481227.operation)
	c:RegisterEffect(e2)
	--atk down
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCondition(c44481227.atkcon)
	e3:SetOperation(c44481227.atkop)
	c:RegisterEffect(e3)
end
function c44481227.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c44481227.filter(c)
	return c:IsFaceup() and not c:IsHasEffect(EFFECT_PIERCE)
end
function c44481227.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c44481227.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c44481227.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c44481227.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c44481227.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()==0 then return end
	local gc=g:GetFirst()
	while gc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_DEFENSE)
		e1:SetValue(-800)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		gc:RegisterEffect(e1)
		gc=g:GetNext()
	end
	if tc:IsRelateToEffect(e) then
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_PIERCE)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
	end
end
function c44481227.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local rc=e:GetHandler():GetReasonCard()
	return rc:IsRelateToBattle()
end
function c44481227.atkop(e,tp,eg,ep,ev,re,r,rp)
	local rc=e:GetHandler():GetReasonCard()
	if rc:IsRelateToBattle() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-800)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		rc:RegisterEffect(e1)
	end
end
