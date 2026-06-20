--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 星级变化  (ID: 63485233)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 165
--
-- Effect Text:
-- ①：可以以场上1只表侧表示怪兽为对象，从以下效果选择1个发动。
-- ●作为对象的怪兽的等级上升1星。
-- ●作为对象的怪兽的等级下降1星。
--[[ __CARD_HEADER_END__ ]]

--スター・チェンジャー
function c63485233.initial_effect(c)
	--lv change
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c63485233.target)
	e1:SetOperation(c63485233.operation)
	c:RegisterEffect(e1)
end
function c63485233.filter(c)
	return c:IsFaceup() and c:IsLevelAbove(1)
end
function c63485233.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c63485233.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c63485233.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c63485233.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	local op=0
	if tc:IsLevel(1) then op=Duel.SelectOption(tp,aux.Stringid(63485233,0))
	else op=Duel.SelectOption(tp,aux.Stringid(63485233,0),aux.Stringid(63485233,1)) end
	e:SetLabel(op)
end
function c63485233.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		if e:GetLabel()==0 then
			e1:SetValue(1)
		else e1:SetValue(-1) end
		tc:RegisterEffect(e1)
	end
end
