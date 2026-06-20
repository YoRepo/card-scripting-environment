--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 古之叶  (ID: 11830996)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己基本分是9000以上的场合，支付2000基本分才能发动。自己从卡组抽2张。
--[[ __CARD_HEADER_END__ ]]

--エンシェント・リーフ
function c11830996.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c11830996.condition)
	e1:SetCost(c11830996.cost)
	e1:SetTarget(c11830996.target)
	e1:SetOperation(c11830996.activate)
	c:RegisterEffect(e1)
end
function c11830996.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)>=9000
end
function c11830996.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,2000)
end
function c11830996.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c11830996.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
