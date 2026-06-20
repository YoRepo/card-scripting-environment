--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 废品收集者  (ID: 58242947)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 5
-- ATK 1000 | DEF 2200
-- Setcode: 67
--
-- Effect Text:
-- 把场上表侧表示存在的这张卡和自己墓地存在的1张通常陷阱卡从游戏中除外发动。这张卡的效果变成和为这个效果发动而从游戏中除外的通常陷阱卡的效果相同。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--ジャンク・コレクター
function c58242947.initial_effect(c)
	--copy trap
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(58242947,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e1)
	e1:SetCost(c58242947.cost)
	e1:SetTarget(c58242947.target)
	e1:SetOperation(c58242947.operation)
	c:RegisterEffect(e1)
end
function c58242947.filter(c)
	return c:GetType()==0x4 and c:IsAbleToRemoveAsCost() and c:CheckActivateEffect(false,true,false)~=nil
end
function c58242947.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c58242947.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(58242947,1))
	local g=Duel.SelectMatchingCard(tp,c58242947.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	local te=g:GetFirst():CheckActivateEffect(false,true,true)
	c58242947[Duel.GetCurrentChain()]=te
	g:AddCard(c)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
---dynamic target
function c58242947.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local te=c58242947[Duel.GetCurrentChain()]
	if chkc then
		local tg=te:GetTarget()
		return tg(e,tp,eg,ep,ev,re,r,rp,0,true)
	end
	if chk==0 then return true end
	if not te then return end
	e:SetProperty(te:GetProperty())
	local tg=te:GetTarget()
	if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
	Duel.ClearOperationInfo(0)
end
function c58242947.operation(e,tp,eg,ep,ev,re,r,rp)
	local te=c58242947[Duel.GetCurrentChain()]
	if not te then return end
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
end
