--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 时空银河支配者  (ID: 44466810)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 28573819
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。自己场上有「银河眼时空龙」怪兽存在的场合，这张卡的发动从手卡也能用。
-- ①：自己·对方的战斗阶段，把自己场上的「银河眼」超量怪兽1个超量素材取除才能发动（自己场上有「混沌No.」怪兽存在的场合，这张卡的发动和效果不会被无效化）。让这个回合召唤·特殊召唤的对方场上的怪兽全部
-- 回到卡组。
--[[ __CARD_HEADER_END__ ]]

--ロード・オブ・ザ・タキオンギャラクシー
local s,id,o=GetID()
function s.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(s.tdcon)
	e1:SetCost(s.tdcost)
	e1:SetTarget(s.tdtg)
	e1:SetOperation(s.tdop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(s.handcon)
	c:RegisterEffect(e2)
	if not s.global_check then
		s.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetOperation(s.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EVENT_SPSUMMON_SUCCESS)
		Duel.RegisterEffect(ge2,0)
	end
end
function s.checkop(e,tp,eg,ep,ev,re,r,rp)
	for tc in aux.Next(eg) do
		tc:RegisterFlagEffect(id,RESET_PHASE+PHASE_END,0,1)
	end
end
function s.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x307b)
end
function s.handcon(e)
	return Duel.IsExistingMatchingCard(s.filter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function s.tdcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE
end
function s.xfilter(c)
	return c:IsSetCard(0x107b) and c:IsType(TYPE_XYZ) and c:IsFaceup()
end
function s.tdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local xg=Group.CreateGroup()
	local mg=Duel.GetMatchingGroup(s.xfilter,tp,LOCATION_MZONE,0,nil)
	for tc in aux.Next(mg) do
		xg:Merge(tc:GetOverlayGroup())
	end
	if chk==0 then return xg:GetCount()>0 end
	local cost=xg:Select(tp,1,1,nil)
	Duel.SendtoGrave(cost,REASON_COST)
end
function s.tdfilter(c)
	return c:GetFlagEffect(id)>0 and c:IsType(TYPE_MONSTER) and c:IsAbleToDeck()
end
function s.cfilter(c)
	return c:IsSetCard(0x1048) and c:IsFaceup()
end
function s.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.tdfilter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(s.tdfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,LOCATION_MZONE)
	if Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_MZONE,0,1,nil) then
		e:SetProperty(EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CAN_FORBIDDEN)
	end
end
function s.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(s.tdfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
end
