--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 娱乐伙伴 鞭子蛇  (ID: 79967395)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Reptile
-- Level 4
-- ATK 1700 | DEF 900
-- Setcode: 159
--
-- Effect Text:
-- ①：1回合1次，以场上1只表侧表示怪兽为对象才能发动。那只怪兽的攻击力·守备力直到回合结束时交换。这个效果在双方的主要阶段才能发动。
--[[ __CARD_HEADER_END__ ]]

--EMウィップ・バイパー
function c79967395.initial_effect(c)
	--swap
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(79967395,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(0,TIMING_MAIN_END)
	e1:SetCountLimit(1)
	e1:SetCondition(c79967395.condition)
	e1:SetTarget(c79967395.target)
	e1:SetOperation(c79967395.operation)
	c:RegisterEffect(e1)
end
function c79967395.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph==PHASE_MAIN1 or ph==PHASE_MAIN2
end
function c79967395.filter(c)
	return c:IsFaceup() and c:IsDefenseAbove(0)
end
function c79967395.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c79967395.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c79967395.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c79967395.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c79967395.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local atk=tc:GetAttack()
		local def=tc:GetDefense()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(def)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e2:SetValue(atk)
		tc:RegisterEffect(e2)
	end
end
