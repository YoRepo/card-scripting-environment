--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 娱乐伙伴 尖刺鹰  (ID: 22091345)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level 2
-- ATK 900 | DEF 900
-- Setcode: 159
--
-- Effect Text:
-- ①：1回合1次，以自己场上1只表侧表示怪兽为对象才能发动。这个回合，那只怪兽向守备表示怪兽攻击的场合，给与对方为攻击力超过那个守备力的数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--EMスパイク・イーグル
function c22091345.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22091345,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetCondition(c22091345.condition)
	e1:SetTarget(c22091345.target)
	e1:SetOperation(c22091345.operation)
	c:RegisterEffect(e1)
end
function c22091345.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c22091345.filter(c)
	return c:IsFaceup() and not c:IsHasEffect(EFFECT_PIERCE)
end
function c22091345.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(c22091345.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c22091345.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c22091345.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_PIERCE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
