--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 王战的支配  (ID: 64325438)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 308
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：对方连锁自己的「王战」卡的效果的发动把魔法·陷阱·怪兽的效果发动时，丢弃1张手卡才能发动。那个对方的效果变成「双方玩家各自从卡组抽1张」。
--[[ __CARD_HEADER_END__ ]]

--王の支配
function c64325438.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(64325438,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--change effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(64325438,1))
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCountLimit(1,64325438)
	e2:SetCondition(c64325438.chcon)
	e2:SetCost(c64325438.chcost)
	e2:SetOperation(c64325438.chop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_SZONE)
	c:RegisterEffect(e3)
end
function c64325438.chcon(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetCurrentChain()
	if ct<2 then return end
	if not Duel.IsPlayerCanDraw(tp,1) or not Duel.IsPlayerCanDraw(1-tp,1) then return false end
	local te,p=Duel.GetChainInfo(ct-1,CHAININFO_TRIGGERING_EFFECT,CHAININFO_TRIGGERING_PLAYER)
	return te and te:GetHandler():IsSetCard(0x134) and p==tp and rp==1-tp
end
function c64325438.chcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD,nil)
end
function c64325438.chop(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	Duel.ChangeTargetCard(ev,g)
	Duel.ChangeChainOperation(ev,c64325438.repop)
end
function c64325438.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.Draw(1-tp,1,REASON_EFFECT)
end
