--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 正义盟军 无限虫  (ID: 82377606)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 2
-- ATK 600 | DEF 200
-- Setcode: 1
--
-- Effect Text:
-- 把这张卡解放发动。自己场上表侧表示存在的1只名字带有「正义盟军」的怪兽的原本攻击力直到这个回合的结束阶段时变成2倍。
--[[ __CARD_HEADER_END__ ]]

--A・O・J アンリミッター
function c82377606.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(82377606,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c82377606.atkcost)
	e1:SetTarget(c82377606.atktg)
	e1:SetOperation(c82377606.atkop)
	c:RegisterEffect(e1)
end
function c82377606.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c82377606.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x1)
end
function c82377606.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c82377606.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c82377606.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c82377606.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c82377606.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local batk=tc:GetBaseAttack()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(batk*2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
