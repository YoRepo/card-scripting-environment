--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 洗脑  (ID: 87910978)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：支付800基本分，以对方场上1只可以通常召唤的表侧表示怪兽为对象才能发动。那只表侧表示怪兽的控制权直到结束阶段得到。
--[[ __CARD_HEADER_END__ ]]

--洗脳－ブレインコントロール
function c87910978.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c87910978.cost)
	e1:SetTarget(c87910978.target)
	e1:SetOperation(c87910978.activate)
	c:RegisterEffect(e1)
end
function c87910978.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,800) end
	Duel.PayLPCost(tp,800)
end
function c87910978.filter(c)
	return c:IsControlerCanBeChanged() and c:IsFaceup() and c:IsSummonableCard()
end
function c87910978.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c87910978.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c87910978.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c87910978.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c87910978.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.GetControl(tc,tp,PHASE_END,1)
	end
end
