--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 闪光吸收  (ID: 90263923)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 选择对方场上表侧表示存在的1只光属性怪兽发动。自己场上表侧攻击表示存在的全部怪兽的攻击力直到结束阶段时上升选择的怪兽的攻击力数值。
--[[ __CARD_HEADER_END__ ]]

--シャイニング・アブソーブ
function c90263923.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c90263923.target)
	e1:SetOperation(c90263923.activate)
	c:RegisterEffect(e1)
end
function c90263923.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c90263923.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c90263923.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c90263923.filter,tp,0,LOCATION_MZONE,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsPosition,tp,LOCATION_MZONE,0,1,nil,POS_FACEUP_ATTACK) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c90263923.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c90263923.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local g=Duel.GetMatchingGroup(Card.IsPosition,tp,LOCATION_MZONE,0,nil,POS_FACEUP_ATTACK)
	if g:GetCount()>0 and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local sc=g:GetFirst()
		local atk=tc:GetAttack()
		while sc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			e1:SetValue(atk)
			sc:RegisterEffect(e1)
			sc=g:GetNext()
		end
	end
end
