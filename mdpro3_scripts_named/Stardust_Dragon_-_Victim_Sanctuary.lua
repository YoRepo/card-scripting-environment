--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 星尘龙-牺牲者的圣域  (ID: 76636978)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Dragon
-- Level 8
-- ATK 2500 | DEF 2000
-- Setcode: 163
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这个卡名的①②的效果1回合各能使用1次，同一连锁上不能发动。
-- ①：对方连锁自己的效果的发动把魔法·陷阱·怪兽的效果发动时，把这张卡解放才能发动。那个对方的效果的发动无效并破坏。
-- ②：自己怪兽被解放的自己·对方回合，把墓地的这张卡除外才能发动。从额外卡组把1只「星尘」同调怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--スターダスト・ドラゴン－ヴィクテム・サンクチュアリ
local s,id,o=GetID()
function s.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.negcon)
	e1:SetCost(s.cost)
	e1:SetTarget(s.negtg)
	e1:SetOperation(s.negop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,id+o)
	e2:SetCondition(s.sscon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(s.sstg)
	e2:SetOperation(s.ssop)
	c:RegisterEffect(e2)
	if not s.global_check then
		s.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_RELEASE)
		ge1:SetOperation(s.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function s.negcon(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsChainDisablable(ev) then return false end
	local te,p=Duel.GetChainInfo(ev-1,CHAININFO_TRIGGERING_EFFECT,CHAININFO_TRIGGERING_PLAYER)
	return te and p==tp and rp==1-tp
end
function s.excostfilter(c,tp)
	return c:IsAbleToRemoveAsCost() and c:IsHasEffect(84012625,tp)
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Group.CreateGroup()
	local c=e:GetHandler()
	if c:IsReleasable() then g:AddCard(c) end
	if c:IsSetCard(0xa3) then g:Merge(Duel.GetMatchingGroup(s.excostfilter,tp,LOCATION_GRAVE,0,nil,tp)) end
	if chk==0 then return #g>0 end
	local tc
	if #g>1 then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(84012625,0))
		tc=g:Select(tp,1,1,nil):GetFirst()
	else
		tc=g:GetFirst()
	end
	local te=tc:IsHasEffect(84012625,tp)
	if te then
		Duel.Remove(tc,POS_FACEUP,REASON_COST+REASON_REPLACE)
	else
		Duel.Release(tc,REASON_COST)
	end
end
function s.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,id+o)==0 end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
	Duel.RegisterFlagEffect(tp,id+o,RESET_CHAIN,0,1)
end
function s.negop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToChain(ev) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function s.chkfilter(c,p)
	return c:GetPreviousControler()==p and (c:IsPreviousLocation(LOCATION_MZONE) or c:IsType(TYPE_MONSTER))
end
function s.checkop(e,tp,eg,ep,ev,re,r,rp)
	for p=0,1 do
		if eg:IsExists(s.chkfilter,1,nil,p) then
			Duel.RegisterFlagEffect(p,id,RESET_PHASE+PHASE_END,0,1)
		end
	end
end
function s.sscon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,id)>0
end
function s.ssfilter(c,e,tp)
	return c:IsSetCard(0xa3) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsType(TYPE_SYNCHRO)
		and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function s.sstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.ssfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp)
		and Duel.GetFlagEffect(tp,id+o)==0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	Duel.RegisterFlagEffect(tp,id+o,RESET_CHAIN,0,1)
end
function s.ssop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.ssfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
