--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 黄昏之堕天使 路西法  (ID: 10136446)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Fairy
-- Level 12
-- ATK 3000 | DEF 3000
-- Setcode: 239
--
-- Effect Text:
-- 6星以上的天使族·暗属性怪兽×2
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：这张卡融合召唤的场合才能发动。从卡组把1张「堕天使」魔法卡和1张「堕天使」陷阱卡在自己场上盖放。
-- ②：对方不能把场上的这张卡作为效果的对象。
-- ③：自己·对方回合，支付1000基本分，以自己墓地1张「堕天使」魔法·陷阱卡为对象才能发动。那张魔法·陷阱卡发动时的效果适用。那之后，那张卡回到卡组。
--[[ __CARD_HEADER_END__ ]]

--黄昏の堕天使ルシファー
local s,id,o=GetID()
function s.initial_effect(c)
	--material
	aux.AddFusionProcFunRep(c,s.matfilter,2,true)
	c:EnableReviveLimit()
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SSET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,id)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(s.setcon)
	e1:SetTarget(s.settg)
	e1:SetOperation(s.setop)
	c:RegisterEffect(e1)
	--cannot target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--copy effect
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e3:SetCountLimit(1,id+o)
	e3:SetCost(s.cpcost)
	e3:SetTarget(s.cptg)
	e3:SetOperation(s.cpop)
	c:RegisterEffect(e3)
end
function s.matfilter(c)
	return c:IsFusionAttribute(ATTRIBUTE_DARK) and c:IsRace(RACE_FAIRY) and c:IsLevelAbove(6)
end
function s.setcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function s.setfilter(c,tp)
	return c:IsSetCard(0xef) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
end
function s.gcheck(sg,tp)
	return sg:IsExists(s.setfilter1,1,nil,tp) and sg:IsExists(s.setfilter2,1,nil,tp)
end
function s.setfilter1(c,tp)
	return c:IsSetCard(0xef) and c:IsType(TYPE_SPELL) and c:IsSSetable()
		and (Duel.GetLocationCount(tp,LOCATION_SZONE)>1
		or Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and c:IsType(TYPE_FIELD))
end
function s.setfilter2(c)
	return c:IsSetCard(0xef) and c:IsType(TYPE_TRAP) and c:IsSSetable()
end
function s.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	local sg=Duel.GetMatchingGroup(s.setfilter,tp,LOCATION_DECK,0,nil,tp)
	if chk==0 then return sg:CheckSubGroup(s.gcheck,2,2,tp) end
end
function s.setop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(s.setfilter,tp,LOCATION_DECK,0,nil,tp)
	if not sg:CheckSubGroup(s.gcheck,2,2,tp) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=sg:SelectSubGroup(tp,s.gcheck,false,2,2,tp)
	if g:GetCount()==2 then
		Duel.SSet(tp,g)
	end
end
function s.cpcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function s.cpfilter(c)
	return c:IsSetCard(0xef) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToDeck() and c:CheckActivateEffect(false,true,false)~=nil
end
function s.cptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then
		local te=e:GetLabelObject()
		local tg=te:GetTarget()
		return tg and tg(e,tp,eg,ep,ev,re,r,rp,0,chkc)
	end
	if chk==0 then return Duel.IsExistingTarget(s.cpfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,s.cpfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	local te,ceg,cep,cev,cre,cr,crp=g:GetFirst():CheckActivateEffect(false,true,true)
	Duel.ClearTargetCard()
	g:GetFirst():CreateEffectRelation(e)
	local tg=te:GetTarget()
	if tg then tg(e,tp,ceg,cep,cev,cre,cr,crp,1) end
	te:SetLabelObject(e:GetLabelObject())
	e:SetLabelObject(te)
	Duel.ClearOperationInfo(0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function s.cpop(e,tp,eg,ep,ev,re,r,rp)
	local te=e:GetLabelObject()
	if not te then return end
	if not te:GetHandler():IsRelateToChain() then return end
	e:SetLabelObject(te:GetLabelObject())
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
	Duel.BreakEffect()
	Duel.SendtoDeck(te:GetHandler(),nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
end
