--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 连环栗仔球  (ID: 24842059)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Cyberse
-- ATK 300 | LINK
--
-- Effect Text:
-- 4星以下的电子界族怪兽1只
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：对方把陷阱卡发动时，把这张卡解放才能发动。那个效果无效并除外。
-- ②：这张卡在墓地存在的场合，把从额外卡组特殊召唤的自己场上1只「@火灵天星」怪兽解放才能发动。这张卡特殊召唤。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--リングリボー
function c24842059.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,c24842059.mfilter,1,1)
	c:EnableReviveLimit()
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(24842059,0))
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,24842059)
	e1:SetCondition(c24842059.discon)
	e1:SetCost(c24842059.discost)
	e1:SetTarget(c24842059.distg)
	e1:SetOperation(c24842059.disop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(24842059,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,24842060)
	e2:SetCost(c24842059.spcost)
	e2:SetTarget(c24842059.sptg)
	e2:SetOperation(c24842059.spop)
	c:RegisterEffect(e2)
end
function c24842059.mfilter(c)
	return c:IsLevelBelow(4) and c:IsLinkRace(RACE_CYBERSE)
end
function c24842059.discon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and re:IsActiveType(TYPE_TRAP) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainDisablable(ev)
end
function c24842059.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c24842059.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return aux.nbcon(tp,re) end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,1,0,0)
	end
	if re:GetActivateLocation()==LOCATION_GRAVE then
		e:SetCategory(e:GetCategory()|CATEGORY_GRAVE_ACTION)
	else
		e:SetCategory(e:GetCategory()&~CATEGORY_GRAVE_ACTION)
	end
end
function c24842059.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Remove(eg,POS_FACEUP,REASON_EFFECT)
	end
end
function c24842059.cfilter(c,tp)
	return c:IsSetCard(0x135) and c:IsSummonLocation(LOCATION_EXTRA) and Duel.GetMZoneCount(tp,c)>0
end
function c24842059.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c24842059.cfilter,1,nil,tp) end
	local g=Duel.SelectReleaseGroup(tp,c24842059.cfilter,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c24842059.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c24842059.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
