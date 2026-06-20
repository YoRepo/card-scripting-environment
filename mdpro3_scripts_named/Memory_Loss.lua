--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 健忘  (ID: 71098407)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方场上表侧攻击表示存在的怪兽的效果发动时才能发动。那个发动的效果无效，那只怪兽变成表侧守备表示。
--[[ __CARD_HEADER_END__ ]]

--もの忘れ
function c71098407.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c71098407.condition)
	e1:SetTarget(c71098407.target)
	e1:SetOperation(c71098407.activate)
	c:RegisterEffect(e1)
end
function c71098407.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainDisablable(ev)
		and re:GetHandler():IsLocation(LOCATION_MZONE) and re:GetHandler():IsPosition(POS_FACEUP_ATTACK)
		and re:GetHandler():IsCanChangePosition()
end
function c71098407.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(re:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c71098407.activate(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if Duel.NegateEffect(ev) and rc:IsRelateToEffect(e) then
		Duel.ChangePosition(rc,POS_FACEUP_DEFENSE)
	end
end
