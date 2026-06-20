--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 亚马逊贤者  (ID: 53162898)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1400 | DEF 700
-- Setcode: 4
--
-- Effect Text:
-- ①：这张卡攻击的伤害步骤结束时，若这张卡在怪兽区域存在，以对方场上1张魔法·陷阱卡为对象发动。那张对方的卡破坏。
--[[ __CARD_HEADER_END__ ]]

--アマゾネスの賢者
function c53162898.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(53162898,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCondition(c53162898.condition)
	e1:SetTarget(c53162898.target)
	e1:SetOperation(c53162898.operation)
	c:RegisterEffect(e1)
end
function c53162898.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttacker() and e:GetHandler():IsRelateToBattle()
end
function c53162898.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c53162898.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c53162898.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c53162898.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c53162898.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
