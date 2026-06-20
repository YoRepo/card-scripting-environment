--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 黑羽-龙卷之哈里肯  (ID: 36442179)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Winged Beast
-- Level 1
-- ATK 0 | DEF 0
-- Setcode: 51
--
-- Effect Text:
-- ①：1回合1次，以场上1只同调怪兽为对象才能发动。这张卡的攻击力直到回合结束时变成和作为对象的怪兽的攻击力相同。
--[[ __CARD_HEADER_END__ ]]

--BF－竜巻のハリケーン
function c36442179.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(36442179,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c36442179.target)
	e1:SetOperation(c36442179.operation)
	c:RegisterEffect(e1)
end
function c36442179.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
end
function c36442179.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c36442179.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c36442179.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c36442179.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c36442179.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) and tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(tc:GetAttack())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
