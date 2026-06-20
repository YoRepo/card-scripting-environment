--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 闪刀姬-魁奈  (ID: 12421694)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Machine
-- ATK 1500 | LINK
-- Setcode: 4373
--
-- Effect Text:
-- 地属性以外的「闪刀姬」怪兽1只
-- 自己对「闪刀姬-魁奈」1回合只能有1次特殊召唤。
-- ①：这张卡特殊召唤成功的场合，以对方场上1只表侧表示怪兽为对象才能发动。那只怪兽直到对方回合结束时不能攻击。
-- ②：只要这张卡在怪兽区域存在，每次自己把「闪刀」魔法卡的效果发动，自己回复100基本分。
--[[ __CARD_HEADER_END__ ]]

--閃刀姫－カイナ
function c12421694.initial_effect(c)
	c:SetSPSummonOnce(12421694)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c12421694.matfilter,1,1)
	--atk limit
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(12421694,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c12421694.atktg)
	e1:SetOperation(c12421694.atkop)
	c:RegisterEffect(e1)
	--recover
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(aux.chainreg)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAIN_SOLVED)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c12421694.reccon)
	e3:SetOperation(c12421694.recop)
	c:RegisterEffect(e3)
end
function c12421694.matfilter(c)
	return c:IsLinkSetCard(0x1115) and c:IsLinkAttribute(ATTRIBUTE_ALL&~ATTRIBUTE_EARTH)
end
function c12421694.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
end
function c12421694.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		tc:RegisterEffect(e1)
	end
end
function c12421694.reccon(e,tp,eg,ep,ev,re,r,rp)
	return re and re:IsActiveType(TYPE_SPELL) and re:GetHandler():IsSetCard(0x115) and rp==tp and e:GetHandler():GetFlagEffect(FLAG_ID_CHAINING)>0
end
function c12421694.recop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Recover(tp,100,REASON_EFFECT)
end
