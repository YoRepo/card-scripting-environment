--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 狱落鸟  (ID: 84845628)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Wyrm
-- Level 8
-- ATK 2700 | DEF 1500
--
-- Effect Text:
-- ①：这张卡的攻击力·守备力上升自己墓地的调整数量×100。
-- ②：1回合1次，把手卡1只调整送去墓地，以对方场上1只怪兽为对象才能发动。那只怪兽的控制权直到结束阶段得到。
--[[ __CARD_HEADER_END__ ]]

--獄落鳥
function c84845628.initial_effect(c)
	--atk & def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c84845628.adval)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
	--control
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_CONTROL)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1)
	e3:SetCost(c84845628.cost)
	e3:SetTarget(c84845628.target)
	e3:SetOperation(c84845628.operation)
	c:RegisterEffect(e3)
end
function c84845628.adval(e,c)
	local tp=c:GetControler()
	return Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_TUNER)*100
end
function c84845628.cfilter(c)
	return c:IsType(TYPE_TUNER) and c:IsAbleToGraveAsCost()
end
function c84845628.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c84845628.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c84845628.cfilter,1,1,REASON_COST,nil)
end
function c84845628.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsControlerCanBeChanged() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c84845628.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.GetControl(tc,tp,PHASE_END,1)
	end
end
