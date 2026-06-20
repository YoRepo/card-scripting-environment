--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 朋克即兴狂热！  (ID: 11441009)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Psychic
-- Rank 8
-- ATK 2800 | DEF 600
-- Setcode: 369
--
-- Effect Text:
-- 8星怪兽×2
-- 「朋克即兴狂热！」1回合1次也能在自己场上的「朋克」融合·同调怪兽上面重叠来超量召唤。这个卡名的①②的效果1回合各能使用1次。
-- ①：支付600基本分，把这张卡1个超量素材取除才能发动。自己抽1张。
-- ②：自己墓地有念动力族·3星怪兽存在，这张卡以外的怪兽的效果发动时，把这张卡1个超量素材取除才能发动。那个发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--P.U.N.K.JAM FEVER!
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddXyzProcedure(c,nil,8,2,s.ovfilter,aux.Stringid(id,0),2,s.xyzop)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,1))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,id)
	e1:SetCost(s.cost)
	e1:SetTarget(s.drtg)
	e1:SetOperation(s.drop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,2))
	e2:SetCategory(CATEGORY_NEGATE|CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,id+o)
	e2:SetCondition(s.negcon)
	e2:SetCost(s.negcost)
	e2:SetTarget(s.negtg)
	e2:SetOperation(s.negop)
	c:RegisterEffect(e2)
end
function s.ovfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x171) and c:IsType(TYPE_FUSION+TYPE_SYNCHRO)
end
function s.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,id)==0 end
	Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) and Duel.CheckLPCost(tp,600) end
	Duel.PayLPCost(tp,600)
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function s.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function s.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function s.cfilter(c)
	return c:IsLevel(3) and c:IsRace(RACE_PSYCHO)
end
function s.negcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.IsChainNegatable(ev) and not c:IsStatus(STATUS_BATTLE_DESTROYED)
		and re:GetHandler()~=c and re:IsActiveType(TYPE_MONSTER)
		and Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function s.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function s.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function s.negop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(re:GetHandler(),REASON_EFFECT)
	end
end
