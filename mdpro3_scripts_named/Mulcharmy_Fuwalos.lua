--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 欢聚友伴·茸茸长尾山雀  (ID: 42141493)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level 4
-- ATK 100 | DEF 600
-- Setcode: 434
--
-- Effect Text:
-- 这张卡的效果发动的回合，自己只能有1次把这张卡以外的「欢聚友伴」怪兽的效果发动。
-- ①：自己·对方回合，自己场上没有卡存在的场合，把这张卡从手卡丢弃才能发动。这个回合中，以下效果适用。
-- ●每次对方从卡组·额外卡组把怪兽特殊召唤，自己抽1张。
-- ●结束阶段，自己手卡比对方场上的卡数量＋6张要多的场合，那个相差数量的自己手卡随机回到卡组。
--[[ __CARD_HEADER_END__ ]]

--マルチャミー・フワロス
local s,id,o=GetID()
function s.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(s.drcon)
	e1:SetCost(s.drcost)
	e1:SetOperation(s.drop)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(id,ACTIVITY_CHAIN,s.chainfilter)
end
function s.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)==0 and Duel.GetCustomActivityCount(id,tp,ACTIVITY_CHAIN)<2
end
function s.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e3:SetCode(EFFECT_CANNOT_ACTIVATE)
	e3:SetTargetRange(1,0)
	e3:SetCondition(s.actcon)
	e3:SetValue(s.aclimit)
	e3:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e3,tp)
end
function s.chainfilter(re,tp,cid)
	return not (re:IsActiveType(TYPE_MONSTER) and re:GetHandler():IsSetCard(0x1b2))
end
function s.actcon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetCustomActivityCount(id,tp,ACTIVITY_CHAIN)>1
end
function s.aclimit(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER) and re:GetHandler():IsSetCard(0x1b2)
end
function s.drop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(s.drcon1)
	e1:SetOperation(s.drop1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(s.regcon)
	e2:SetOperation(s.regop)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EVENT_CHAIN_SOLVED)
	e3:SetCondition(s.drcon2)
	e3:SetOperation(s.drop2)
	e3:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e3,tp)
	local e4=Effect.CreateEffect(e:GetHandler())
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetCountLimit(1)
	e4:SetCondition(s.tdcon)
	e4:SetOperation(s.tdop)
	e4:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e4,tp)
end
function s.filter(c,sp)
	return c:IsSummonPlayer(sp) and c:IsSummonLocation(LOCATION_DECK+LOCATION_EXTRA)
		and c:GetOriginalType()&TYPE_MONSTER~=0
end
function s.drcon1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.filter,1,nil,1-tp)
		and not Duel.IsChainSolving()
end
function s.drop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
end
function s.regcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.filter,1,nil,1-tp)
		and Duel.IsChainSolving()
end
function s.regop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RegisterFlagEffect(tp,id+o,RESET_CHAIN,0,1)
end
function s.drcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,id+o)>0
end
function s.drop2(e,tp,eg,ep,ev,re,r,rp)
	local n=Duel.GetFlagEffect(tp,id+o)
	Duel.ResetFlagEffect(tp,id+o)
	Duel.Draw(tp,n,REASON_EFFECT)
end
function s.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(e:GetOwnerPlayer(),LOCATION_HAND,0)>Duel.GetFieldGroupCount(e:GetOwnerPlayer(),0,LOCATION_ONFIELD)+6
end
function s.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(e:GetOwnerPlayer(),LOCATION_HAND,0)
	local d=Duel.GetFieldGroupCount(e:GetOwnerPlayer(),LOCATION_HAND,0)-(Duel.GetFieldGroupCount(e:GetOwnerPlayer(),0,LOCATION_ONFIELD)+6)
	local sg=g:RandomSelect(e:GetOwnerPlayer(),d)
	Duel.SendtoDeck(sg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
end
