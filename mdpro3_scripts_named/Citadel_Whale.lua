--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 城塞鲸  (ID: 46290741)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level 7
-- ATK 2350 | DEF 2150
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡在手卡·墓地存在的场合，把自己场上2只水属性怪兽解放才能发动。这张卡特殊召唤。
-- ②：这张卡特殊召唤成功的场合才能发动。从卡组选1张「潜海奇袭」在自己场上盖放。
-- ③：1回合1次，只以自己场上的水属性怪兽1只为对象的魔法·陷阱·怪兽的效果由对方发动时才能发动。那个发动无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--城塞クジラ
function c46290741.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46290741,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCountLimit(1,46290741)
	e1:SetCost(c46290741.spcost)
	e1:SetTarget(c46290741.sptg)
	e1:SetOperation(c46290741.spop)
	c:RegisterEffect(e1)
	--sset
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(46290741,1))
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCategory(CATEGORY_SSET)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetTarget(c46290741.settg)
	e2:SetOperation(c46290741.setop)
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(46290741,2))
	e3:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c46290741.discon)
	e3:SetTarget(c46290741.distg)
	e3:SetOperation(c46290741.disop)
	c:RegisterEffect(e3)
end
function c46290741.rfilter(c,tp)
	return c:IsAttribute(ATTRIBUTE_WATER) and (c:IsControler(tp) or c:IsFaceup())
end
function c46290741.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local rg=Duel.GetReleaseGroup(tp):Filter(c46290741.rfilter,nil,tp)
	if chk==0 then return rg:CheckSubGroup(aux.mzctcheckrel,2,2,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=rg:SelectSubGroup(tp,aux.mzctcheckrel,false,2,2,tp)
	aux.UseExtraReleaseCount(g,tp)
	Duel.Release(g,REASON_COST)
end
function c46290741.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c46290741.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c46290741.filter(c)
	return c:IsCode(19089195) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
end
function c46290741.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c46290741.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c46290741.setop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c46290741.filter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.SSet(tp,tc)
	end
end
function c46290741.tfilter(c,tp)
	return c:IsLocation(LOCATION_MZONE) and c:IsAttribute(ATTRIBUTE_WATER) and c:IsControler(tp)
end
function c46290741.discon(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return tg and tg:GetCount()==1 and tg:IsExists(c46290741.tfilter,1,nil,tp) and Duel.IsChainNegatable(ev)
end
function c46290741.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c46290741.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
