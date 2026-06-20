--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 娱乐伙伴 万花筒蝎  (ID: 78835747)
-- Type: Monster / Effect / Pendulum
-- Attribute: LIGHT
-- Race: Insect
-- Level 6
-- Pendulum Scales: L4 / R4
-- ATK 100 | DEF 2300
-- Setcode: 159
--
-- Effect Text:
-- ←4 【灵摆】 4→
-- ①：自己场上的光属性怪兽的攻击力上升300。
-- 【怪兽效果】
-- ①：1回合1次，以自己场上1只表侧表示怪兽为对象才能发动。这个回合，那只怪兽可以向对方场上的特殊召唤的怪兽全部各作1次攻击。
--[[ __CARD_HEADER_END__ ]]

--EMカレイドスコーピオン
function c78835747.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c78835747.atktg)
	e2:SetValue(300)
	c:RegisterEffect(e2)
	--attack all
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(78835747,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1)
	e3:SetCondition(c78835747.condition)
	e3:SetTarget(c78835747.target)
	e3:SetOperation(c78835747.operation)
	c:RegisterEffect(e3)
end
function c78835747.atktg(e,c)
	return c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c78835747.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c78835747.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end
function c78835747.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_ATTACK_ALL)
		e1:SetValue(c78835747.atkfilter)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c78835747.atkfilter(e,c)
	return c:IsSummonType(SUMMON_TYPE_SPECIAL)
end
