--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 英雄之心  (ID: 67951831)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 选择自己场上1只表侧表示存在的名字带有「元素英雄」的怪兽发动。这个回合选择的怪兽的攻击力变成一半，同1次战斗阶段中可以攻击2次。
--[[ __CARD_HEADER_END__ ]]

--ヒーローハート
function c67951831.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c67951831.target)
	e1:SetOperation(c67951831.activate)
	c:RegisterEffect(e1)
end
function c67951831.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x3008)
end
function c67951831.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c67951831.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c67951831.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c67951831.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c67951831.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(math.ceil(tc:GetAttack()/2))
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_EXTRA_ATTACK)
		e2:SetValue(1)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
	end
end
