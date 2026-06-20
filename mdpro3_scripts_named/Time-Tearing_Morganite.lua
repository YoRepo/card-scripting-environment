--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 撕裂时间的魔瞳  (ID: 19403423)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 443
--
-- Effect Text:
-- ①：这次决斗中，以下效果各适用。
-- ●自己不能把手卡的怪兽的效果发动。
-- ●自己抽卡阶段的通常抽卡变成2张。
-- ●自己1回合可以进行通常召唤最多2次。
-- ②：把墓地的这张卡除外，从手卡丢弃1张「撕裂时间的魔瞳」才能发动。这个回合，在自己怪兽的召唤成功时对方不能把怪兽的效果发动。
--[[ __CARD_HEADER_END__ ]]

--時を裂く魔瞳
function c19403423.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(19403423,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c19403423.target)
	e1:SetOperation(c19403423.activate)
	e1:SetLabel(19403423)
	c:RegisterEffect(e1)
	--act limit
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(19403423,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(c19403423.cost)
	e2:SetTarget(c19403423.target)
	e2:SetOperation(c19403423.operation)
	e2:SetLabel(19403424)
	c:RegisterEffect(e2)
end
function c19403423.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=e:GetLabel()
	if chk==0 then return Duel.GetFlagEffect(tp,ct)==0 end
end
function c19403423.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(19403423,2))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,0)
	e1:SetValue(c19403423.aclimit)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_DRAW_COUNT)
	e2:SetTargetRange(1,0)
	e2:SetValue(2)
	Duel.RegisterEffect(e2,tp)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SET_SUMMON_COUNT_LIMIT)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,0)
	e3:SetValue(2)
	Duel.RegisterEffect(e3,tp)
	Duel.RegisterFlagEffect(tp,19403423,0,0,1)
end
function c19403423.aclimit(e,re,tp)
	return re:GetActivateLocation()==LOCATION_HAND and re:IsActiveType(TYPE_MONSTER)
end
function c19403423.filter(c)
	return c:IsCode(19403423) and c:IsDiscardable()
end
function c19403423.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c19403423.filter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Remove(c,POS_FACEUP,REASON_COST)
	Duel.DiscardHand(tp,c19403423.filter,1,1,REASON_COST+REASON_DISCARD,nil)
end
function c19403423.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c19403423.nsumcon)
	e1:SetOperation(c19403423.nsumsuc)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,19403424,RESET_PHASE+PHASE_END,0,1)
end
function c19403423.nsumcon(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	return ec and ec:IsControler(tp)
end
function c19403423.nsumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimitTillChainEnd(c19403423.efun)
end
function c19403423.efun(e,ep,tp)
	return ep==tp or not e:IsActiveType(TYPE_MONSTER)
end
