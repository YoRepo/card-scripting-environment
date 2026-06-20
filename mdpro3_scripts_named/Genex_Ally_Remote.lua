--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 盟军·次世代遥控员  (ID: 57238939)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Machine
-- Level 3
-- ATK 500 | DEF 1800
-- Setcode: 2
--
-- Effect Text:
-- ①：1回合1次，以场上1只调整为对象才能发动。那只怪兽的卡名直到结束阶段当作「次世代控制员」使用。
--[[ __CARD_HEADER_END__ ]]

--A・ジェネクス・リモート
function c57238939.initial_effect(c)
	--cos
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(57238939,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c57238939.costg)
	e1:SetOperation(c57238939.cosop)
	c:RegisterEffect(e1)
end
function c57238939.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_TUNER)
end
function c57238939.costg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c57238939.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c57238939.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c57238939.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c57238939.cosop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(68505803)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
