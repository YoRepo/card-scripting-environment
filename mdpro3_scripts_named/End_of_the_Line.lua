--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 走魔灯  (ID: 53442500)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己基本分未满100的场合才能发动。自己从卡组抽2张。自己基本分未满10的场合，再让自己从卡组抽2张。
--[[ __CARD_HEADER_END__ ]]

--走魔灯
function c53442500.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCondition(c53442500.condition)
	e1:SetTarget(c53442500.target)
	e1:SetOperation(c53442500.operation)
	c:RegisterEffect(e1)
end
function c53442500.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<100
end
function c53442500.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=2
	if Duel.GetLP(tp)<10 then ct=4 end
	if chk==0 then return Duel.IsPlayerCanDraw(tp,ct) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(ct)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,ct)
end
function c53442500.operation(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	if Duel.Draw(p,2,REASON_EFFECT)>0 and Duel.GetLP(p)<10 then
		Duel.BreakEffect()
		Duel.Draw(p,2,REASON_EFFECT)
	end
end
