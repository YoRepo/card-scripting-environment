--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 卫星闪灵伽马暴  (ID: 42431833)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 384
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：场上的全部2星·2阶·连接2的怪兽的攻击力·守备力直到回合结束时上升1400。
-- ②：自己主要阶段把墓地的这张卡除外，以自己场上1只2星·2阶·连接2的怪兽为对象才能发动。那只怪兽的攻击力直到对方回合结束时上升1400。
--[[ __CARD_HEADER_END__ ]]

--スプライト・ガンマ・バースト
function c42431833.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,42431833)
	e1:SetCondition(aux.dscon)
	e1:SetTarget(c42431833.target)
	e1:SetOperation(c42431833.activate)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,42431833)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c42431833.atktg)
	e2:SetOperation(c42431833.atkop)
	c:RegisterEffect(e2)
end
function c42431833.filter(c)
	return (c:IsLevel(2) or c:IsRank(2) or c:IsLink(2)) and c:IsFaceup()
end
function c42431833.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c42431833.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c42431833.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c42431833.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1400)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end
function c42431833.atkfilter(c)
	return (c:IsLevel(2) or c:IsRank(2) or c:IsLink(2)) and c:IsFaceup()
end
function c42431833.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c42431833.atkfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c42431833.atkfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c42431833.atkfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c42431833.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1400)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		tc:RegisterEffect(e1)
	end
end
