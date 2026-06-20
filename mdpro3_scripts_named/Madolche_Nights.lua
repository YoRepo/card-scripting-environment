--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 魔导人偶之夜  (ID: 79759367)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
-- Setcode: 113
--
-- Effect Text:
-- 自己墓地没有怪兽存在的场合才能发动。效果怪兽的效果的发动无效。自己场上有「魔偶甜点·布丁公主」存在的场合，再让对方手卡随机1张回到卡组。
--[[ __CARD_HEADER_END__ ]]

--魔導人形の夜
function c79759367.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c79759367.condition)
	e1:SetTarget(c79759367.target)
	e1:SetOperation(c79759367.activate)
	c:RegisterEffect(e1)
end
function c79759367.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev)
		and not Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,1,nil,TYPE_MONSTER)
end
function c79759367.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c79759367.cfilter(c)
	return c:IsFaceup() and c:IsCode(74641045)
end
function c79759367.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and Duel.IsExistingMatchingCard(c79759367.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
		and Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 then
		local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND):RandomSelect(tp,1)
		Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
