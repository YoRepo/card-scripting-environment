--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 密探蜘蛛  (ID: 4941482)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level 4
-- ATK 500 | DEF 1800
--
-- Effect Text:
-- 场上存在的这张卡被卡的效果送去墓地时，得到对方场上守备表示存在的1只怪兽的控制权。
--[[ __CARD_HEADER_END__ ]]

--インフォーマー・スパイダー
function c4941482.initial_effect(c)
	--control
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_CONTROL)
	e2:SetDescription(aux.Stringid(4941482,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c4941482.condition)
	e2:SetTarget(c4941482.target)
	e2:SetOperation(c4941482.operation)
	c:RegisterEffect(e2)
end
function c4941482.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsReason(REASON_EFFECT)
end
function c4941482.filter(c)
	return c:IsDefensePos() and c:IsControlerCanBeChanged()
end
function c4941482.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c4941482.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c4941482.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,g:GetCount(),0,0)
end
function c4941482.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsDefensePos() and tc:IsRelateToEffect(e) then
		Duel.GetControl(tc,tp)
	end
end
