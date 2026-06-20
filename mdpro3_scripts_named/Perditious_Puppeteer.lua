--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 地狱的傀儡魔人  (ID: 71564150)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 7
-- ATK 2700 | DEF 500
-- Setcode: 109
--
-- Effect Text:
-- 1回合1次，可以丢弃1张手卡，对方场上表侧表示存在的全部3星以下的怪兽的控制权直到结束阶段时得到。这个效果得到控制权的怪兽不能把效果发动，也不能解放和作为同调素材。
--[[ __CARD_HEADER_END__ ]]

--地獄の傀儡魔人
function c71564150.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c71564150.cost)
	e1:SetTarget(c71564150.target)
	e1:SetOperation(c71564150.operation)
	c:RegisterEffect(e1)
end
function c71564150.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c71564150.filter(c)
	return c:IsFaceup() and c:IsLevelBelow(3) and c:IsControlerCanBeChanged()
end
function c71564150.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c71564150.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,nil,1,1-tp,LOCATION_MZONE)
end
function c71564150.operation(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectMatchingCard(tp,c71564150.filter,tp,0,LOCATION_MZONE,ft,ft,nil)
	Duel.GetControl(g,tp,PHASE_END,1)
	local og=Duel.GetOperatedGroup()
	local tc=og:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UNRELEASABLE_SUM)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_PHASE+PHASE_END)
		e1:SetValue(1)
		tc:RegisterEffect(e1,true)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UNRELEASABLE_NONSUM)
		tc:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_CANNOT_TRIGGER)
		tc:RegisterEffect(e3)
		local e4=e1:Clone()
		e4:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
		tc:RegisterEffect(e4)
		tc=og:GetNext()
	end
end
