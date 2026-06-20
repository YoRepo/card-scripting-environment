--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 魂之一击  (ID: 36376145)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己基本分是4000以下的场合，自己场上的怪兽和对方怪兽进行战斗的攻击宣言时把基本分支付一半，选择自己场上1只怪兽才能发动。选择的怪兽的攻击力直到对方的结束阶段时上升自己基本分比4000低的数值。「魂
-- 之一击」在1回合只能发动1张。
--[[ __CARD_HEADER_END__ ]]

--魂の一撃
function c36376145.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,36376145+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c36376145.condition)
	e1:SetCost(c36376145.cost)
	e1:SetTarget(c36376145.target)
	e1:SetOperation(c36376145.activate)
	c:RegisterEffect(e1)
end
function c36376145.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<=4000 and Duel.GetAttackTarget()~=nil
end
function c36376145.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end
function c36376145.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end
function c36376145.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(4000-Duel.GetLP(tp))
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		tc:RegisterEffect(e1)
	end
end
