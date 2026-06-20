--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 甲蜂  (ID: 86915847)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Insect
-- Level 4
-- ATK 1600 | DEF 1200
--
-- Effect Text:
-- 1回合1次，选择对方场上表侧表示存在的1只怪兽才能发动。选择的对方怪兽的攻击力直到结束阶段时变成一半数值。
--[[ __CARD_HEADER_END__ ]]

--アーマード・ビー
function c86915847.initial_effect(c)
	--atk down
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(86915847,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c86915847.target)
	e1:SetOperation(c86915847.operation)
	c:RegisterEffect(e1)
end
function c86915847.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsFaceup() and chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
end
function c86915847.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(math.ceil(tc:GetAttack()/2))
		tc:RegisterEffect(e1)
	end
end
