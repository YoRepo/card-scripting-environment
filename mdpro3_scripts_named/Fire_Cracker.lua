--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 爆竹鬼  (ID: 81109178)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Fiend
-- Level 4
-- ATK 1700 | DEF 200
--
-- Effect Text:
-- 「爆竹鬼」的①的效果1回合只能使用1次。
-- ①：把这张卡从手卡丢弃才能发动。给与对方1000伤害，下次的自己抽卡阶段跳过。这个效果在对方回合也能发动。
-- ②：只要这张卡在怪兽区域存在，每次对方受到效果伤害给这张卡放置1个指示物。
-- ③：自己·对方的结束阶段发动。这张卡的指示物全部取除，给与对方那个数量×300伤害。
--[[ __CARD_HEADER_END__ ]]

--ファイヤークラッカー
function c81109178.initial_effect(c)
	c:EnableCounterPermit(0x42)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(81109178,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,81109178)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c81109178.damcost1)
	e1:SetTarget(c81109178.damtg1)
	e1:SetOperation(c81109178.damop1)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DAMAGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c81109178.ctcon)
	e2:SetOperation(c81109178.ctop)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(81109178,1))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c81109178.damtg2)
	e3:SetOperation(c81109178.damop2)
	c:RegisterEffect(e3)
end
function c81109178.damcost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c81109178.damtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c81109178.damop1(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Damage(p,d,REASON_EFFECT)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_SKIP_DP)
		e1:SetTargetRange(1,0)
		e1:SetReset(RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN)
		Duel.RegisterEffect(e1,tp)
	end
end
function c81109178.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and bit.band(r,REASON_EFFECT)~=0
end
function c81109178.ctop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x42,1)
end
function c81109178.damtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=e:GetHandler():GetCounter(0x42)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(ct)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct)
end
function c81109178.damop2(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local c=e:GetHandler()
	local ct=c:GetCounter(0x42)
	if c:RemoveCounter(tp,0x42,ct,REASON_EFFECT) then
		Duel.Damage(p,ct*300,REASON_EFFECT)
	end
end
