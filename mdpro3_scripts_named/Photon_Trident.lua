--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:29
-- Card: 光子三叉戟  (ID: 51589188)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 85
--
-- Effect Text:
-- 选择自己场上1只名字带有「光子」的怪兽才能发动。直到结束阶段时，选择的怪兽的攻击力上升700，向守备表示怪兽攻击时，若攻击力超过那个守备力，给与对方基本分那个数值的战斗伤害。此外，选择的怪兽给与对方基
-- 本分战斗伤害时，可以选择场上1张魔法·陷阱卡破坏。
--[[ __CARD_HEADER_END__ ]]

--フォトン・トライデント
function c51589188.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(aux.dscon)
	e1:SetTarget(c51589188.target)
	e1:SetOperation(c51589188.activate)
	c:RegisterEffect(e1)
end
function c51589188.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x55)
end
function c51589188.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c51589188.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c51589188.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c51589188.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c51589188.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsImmuneToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(700)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_PIERCE)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetDescription(aux.Stringid(51589188,0))
		e3:SetCategory(CATEGORY_DESTROY)
		e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
		e3:SetCode(EVENT_BATTLE_DAMAGE)
		e3:SetLabelObject(tc)
		e3:SetCondition(c51589188.descon)
		e3:SetTarget(c51589188.destg)
		e3:SetOperation(c51589188.desop)
		e3:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e3,tp)
	end
end
function c51589188.descon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and eg:GetFirst()==e:GetLabelObject()
end
function c51589188.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c51589188.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c51589188.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c51589188.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c51589188.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c51589188.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
