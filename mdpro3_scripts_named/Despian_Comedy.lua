--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 喜剧之死狱乡演员  (ID: 90179822)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fairy
-- Level 1
-- ATK 0 | DEF 2000
-- Setcode: 356
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：自己场上的表侧表示的「死狱乡」卡为对象的魔法·陷阱·怪兽的效果由对方发动时，把这张卡从手卡丢弃才能发动。那个效果无效。
-- ②：自己·对方回合，这张卡在墓地存在的场合，把自己场上1只融合怪兽解放才能发动。这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--喜劇のデスピアン
function c90179822.initial_effect(c)
	--disable effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90179822,0))
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,90179822)
	e1:SetCondition(c90179822.discon)
	e1:SetCost(c90179822.discost)
	e1:SetTarget(c90179822.distg)
	e1:SetOperation(c90179822.disop)
	c:RegisterEffect(e1)
	--special summon itself
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90179822,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,90179822)
	e2:SetCost(c90179822.spcost)
	e2:SetTarget(c90179822.sptg)
	e2:SetOperation(c90179822.spop)
	c:RegisterEffect(e2)
end
function c90179822.cfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x164) and c:IsControler(tp) and c:IsOnField()
end
function c90179822.discon(e,tp,eg,ep,ev,re,r,rp)
	if not (rp==1-tp and re:IsHasProperty(EFFECT_FLAG_CARD_TARGET)) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return g and g:IsExists(c90179822.cfilter,1,nil,tp) and Duel.IsChainDisablable(ev)
end
function c90179822.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c90179822.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c90179822.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
function c90179822.rfilter(c,tp)
	return c:IsType(TYPE_FUSION) and (c:IsControler(tp) or c:IsFaceup()) and Duel.GetMZoneCount(tp,c)>0
end
function c90179822.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c90179822.rfilter,1,nil,tp) end
	local rg=Duel.SelectReleaseGroup(tp,c90179822.rfilter,1,1,nil,tp)
	Duel.Release(rg,REASON_COST)
end
function c90179822.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c90179822.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
