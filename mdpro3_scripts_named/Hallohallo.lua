--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 万万圣  (ID: 77994337)
-- Type: Monster / Normal / Tuner / Pendulum
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- Pendulum Scales: L2 / R2
-- ATK 800 | DEF 600
--
-- Effect Text:
-- ←2 【灵摆】 2→
-- ①：1回合1次，以场上1只表侧表示怪兽为对象才能发动。掷1次骰子。那只怪兽的等级直到回合结束时变成和出现的数目相同等级。
-- 【怪兽描述】
-- 万万圣爱甜甜糖。
-- 找糖糖，这逛逛，那瞧瞧。
-- 不给糖果就捣蛋，招招耍你团团转。
--
-- 心慌慌已来不及。
-- 花样万变请期待。
--[[ __CARD_HEADER_END__ ]]

--ハロハロ
function c77994337.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--level
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(77994337,0))
	e1:SetCategory(CATEGORY_DICE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c77994337.lvtg)
	e1:SetOperation(c77994337.lvop)
	c:RegisterEffect(e1)
end
function c77994337.lvfilter(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c77994337.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c77994337.lvfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c77994337.lvfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c77994337.lvfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c77994337.lvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local dc=Duel.TossDice(tp,1)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(dc)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
