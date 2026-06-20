--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 红靴子  (ID: 50122883)
-- Type: Monster / Effect / Toon
-- Attribute: DARK
-- Race: Fiend
-- Level 2
-- ATK 500 | DEF 300
--
-- Effect Text:
-- 反转：选择表侧表示的1只怪兽改变表示形式。
--[[ __CARD_HEADER_END__ ]]

--朱い靴
function c50122883.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(50122883,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c50122883.target)
	e1:SetOperation(c50122883.operation)
	c:RegisterEffect(e1)
end
function c50122883.filter(c)
	return c:IsFaceup() and c:IsCanChangePosition()
end
function c50122883.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c50122883.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c50122883.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c50122883.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
	end
end
