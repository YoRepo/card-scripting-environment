--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 六花的白姬  (ID: 132308)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Plant
-- Level 4
-- ATK 0 | DEF 0
-- Setcode: 321
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己主要阶段才能发动。这张卡从手卡特殊召唤。只要这个效果特殊召唤的这张卡在怪兽区域表侧表示存在，自己不是植物族怪兽不能特殊召唤。
-- ②：自己场上有「六花」怪兽存在，对方把怪兽的效果发动时，让手卡·墓地的这张卡回到卡组，把自己场上1只植物族怪兽解放才能发动。那个发动的效果无效。
--[[ __CARD_HEADER_END__ ]]

--六花のしらひめ
function c132308.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,132308)
	e1:SetTarget(c132308.sptg)
	e1:SetOperation(c132308.spop)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e2:SetCountLimit(1,132309)
	e2:SetCondition(c132308.discon)
	e2:SetCost(c132308.discost)
	e2:SetTarget(c132308.distg)
	e2:SetOperation(c132308.disop)
	c:RegisterEffect(e2)
end
function c132308.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c132308.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetAbsoluteRange(tp,1,0)
		e1:SetTarget(c132308.splimit)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1,true)
	end
end
function c132308.splimit(e,c)
	return not c:IsRace(RACE_PLANT)
end
function c132308.filter(c)
	return c:IsSetCard(0x141) and c:IsFaceup()
end
function c132308.discon(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp and Duel.IsChainDisablable(ev) and re:IsActiveType(TYPE_MONSTER)
		and Duel.IsExistingMatchingCard(c132308.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c132308.costfilter(c,tp)
	return (c:IsControler(tp) or c:IsFaceup())
		and (c:IsRace(RACE_PLANT) or c:IsHasEffect(76869711,tp) and c:IsControler(1-tp))
end
function c132308.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckAsCost() and Duel.CheckReleaseGroup(tp,c132308.costfilter,1,nil,tp) end
	Duel.ConfirmCards(1-tp,e:GetHandler())
	Duel.SendtoDeck(e:GetHandler(),nil,SEQ_DECKSHUFFLE,REASON_COST)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectReleaseGroup(tp,c132308.costfilter,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c132308.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c132308.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
