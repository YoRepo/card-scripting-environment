--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: No.88 机关傀儡-命运狮子  (ID: 48995978)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Machine
-- Rank 8
-- ATK 3200 | DEF 2300
-- Setcode: 277020744
--
-- Effect Text:
-- 8星怪兽×3
-- 这张卡有3个命运指示物被放置时，自己决斗胜利。
-- ①：1回合1次，自己的魔法与陷阱区域没有卡存在的场合才能发动。这张卡1个超量素材取除，给这张卡放置1个命运指示物。这个效果发动的回合，自己不能进行战斗阶段。
--[[ __CARD_HEADER_END__ ]]

--No.88 ギミック・パペット－デステニー・レオ
function c48995978.initial_effect(c)
	c:EnableCounterPermit(0x2b)
	--xyz summon
	aux.AddXyzProcedure(c,nil,8,3)
	c:EnableReviveLimit()
	--counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(48995978,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c48995978.condition)
	e1:SetCost(c48995978.cost)
	e1:SetTarget(c48995978.target)
	e1:SetOperation(c48995978.operation)
	c:RegisterEffect(e1)
	--win
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetOperation(c48995978.winop)
	c:RegisterEffect(e2)
end
aux.xyz_number[48995978]=88
function c48995978.filter(c)
	return c:GetSequence()<5
end
function c48995978.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c48995978.filter,tp,LOCATION_SZONE,0,1,nil)
end
function c48995978.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCurrentPhase()==PHASE_MAIN1 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c48995978.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_EFFECT)
		and e:GetHandler():IsCanAddCounter(0x2b,1) end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0x2b)
end
function c48995978.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() and c:RemoveOverlayCard(tp,1,1,REASON_EFFECT) then
		c:AddCounter(0x2b,1)
	end
end
function c48995978.winop(e,tp,eg,ep,ev,re,r,rp)
	local WIN_REASON_DESTINY_LEO=0x17
	local c=e:GetHandler()
	if c:GetCounter(0x2b)==3 then
		Duel.Win(tp,WIN_REASON_DESTINY_LEO)
	end
end
