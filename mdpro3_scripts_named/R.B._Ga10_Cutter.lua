--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 奏悦机组 筑工切割机  (ID: 33438265)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 4
-- ATK 700 | DEF 700
-- Setcode: 463
--
-- Effect Text:
-- 自己场上的表侧表示怪兽不存在的场合或者只有「奏悦机组」怪兽的场合，这张卡可以从手卡特殊召唤。自己对「奏悦机组 筑工切割机」的这个方法的特殊召唤1回合只能有1次。
-- 这张卡在「奏悦机组」连接怪兽所连接区存在，对方把魔法·陷阱卡的效果发动时（诱发即时效果）：可以支付700基本分；这张卡破坏，那个效果无效并破坏。「奏悦机组 筑工切割机」的这个效果1回合只能使用1次。
--
--[[ __CARD_HEADER_END__ ]]

--R.B. Ga10 Cutter
local s,id,o=GetID()
function s.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(s.spcon)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_DISABLE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,id)
	e2:SetCondition(s.discon)
	e2:SetCost(s.discost)
	e2:SetTarget(s.distg)
	e2:SetOperation(s.disop)
	c:RegisterEffect(e2)
end
function s.cfilter(c)
	return c:IsFaceup() and not c:IsSetCard(0x1cf)
end
function s.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and not Duel.IsExistingMatchingCard(s.cfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function s.ecfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1cf) and c:IsType(TYPE_LINK)
end
function s.discon(e,tp,eg,ep,ev,re,r,rp)
	local lg=Duel.GetMatchingGroup(s.ecfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local lg2=Group.CreateGroup()
	for lc in aux.Next(lg) do
		lg2:Merge(lc:GetLinkedGroup())
	end
	return lg2 and lg2:IsContains(e:GetHandler())
		and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
		and ep~=tp and re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and Duel.IsChainDisablable(ev)
end
function s.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,700) end
	Duel.PayLPCost(tp,700)
end
function s.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	local dg=Group.FromCards(e:GetHandler())
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		dg:Merge(eg)
	end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,#dg,0,0)
end
function s.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToChain() and Duel.Destroy(c,REASON_EFFECT)>0
		and Duel.NegateEffect(ev) and re:GetHandler():IsRelateToChain(ev) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
