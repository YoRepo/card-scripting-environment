--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 呼唤虚无的咒文  (ID: 24838456)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 连锁4以后把基本分支付一半才能发动。这张卡的发动时积累的连锁上的全部卡的发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--虚無を呼ぶ呪文
function c24838456.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c24838456.condition)
	e1:SetCost(c24838456.cost)
	e1:SetTarget(c24838456.target)
	e1:SetOperation(c24838456.activate)
	c:RegisterEffect(e1)
end
function c24838456.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()>=3
end
function c24838456.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end
function c24838456.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ng=Group.CreateGroup()
	local dg=Group.CreateGroup()
	for i=1,ev do
		local te=Duel.GetChainInfo(i,CHAININFO_TRIGGERING_EFFECT)
		if te:IsHasType(EFFECT_TYPE_ACTIVATE) or te:IsActiveType(TYPE_MONSTER) then
			local tc=te:GetHandler()
			ng:AddCard(tc)
			if tc:IsRelateToEffect(te) then
				dg:AddCard(tc)
			end
		end
	end
	Duel.SetTargetCard(dg)
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,ng,ng:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,dg:GetCount(),0,0)
end
function c24838456.activate(e,tp,eg,ep,ev,re,r,rp)
	local dg=Group.CreateGroup()
	for i=1,ev do
		local te=Duel.GetChainInfo(i,CHAININFO_TRIGGERING_EFFECT)
		local tc=te:GetHandler()
		if (te:IsHasType(EFFECT_TYPE_ACTIVATE) or te:IsActiveType(TYPE_MONSTER))
			and Duel.NegateActivation(i) and tc:IsRelateToEffect(e) and tc:IsRelateToEffect(te) then
			dg:AddCard(tc)
		end
	end
	Duel.Destroy(dg,REASON_EFFECT)
end
