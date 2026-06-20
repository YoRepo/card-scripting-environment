--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 积累的幸福  (ID: 98444741)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 连锁4以后才能发动。从自己卡组抽2张卡。同1组连锁上有复数次同名卡的效果发动的场合，这张卡不能发动。
--[[ __CARD_HEADER_END__ ]]

--積み上げる幸福
function c98444741.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c98444741.condition)
	e1:SetTarget(c98444741.target)
	e1:SetOperation(c98444741.activate)
	c:RegisterEffect(e1)
end
function c98444741.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()>2 and Duel.CheckChainUniqueness()
end
function c98444741.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c98444741.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
