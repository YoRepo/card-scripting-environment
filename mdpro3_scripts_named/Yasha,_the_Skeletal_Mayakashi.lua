--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 骸之魔妖-夜叉  (ID: 77714963)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 5
-- ATK 2000 | DEF 0
-- Setcode: 289
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：从手卡把这张卡以外的1只「魔妖」怪兽丢弃才能发动。这张卡从手卡特殊召唤。
-- ②：只要这张卡在怪兽区域存在，自己不是「魔妖」怪兽不能从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--骸の魔妖－夜叉
function c77714963.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(77714963,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,77714963)
	e1:SetCost(c77714963.spcost)
	e1:SetTarget(c77714963.sptg)
	e1:SetOperation(c77714963.spop)
	c:RegisterEffect(e1)
	--spsummon limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c77714963.sslimit)
	c:RegisterEffect(e2)
end
function c77714963.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x121) and c:IsDiscardable()
end
function c77714963.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c77714963.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c77714963.cfilter,1,1,REASON_COST+REASON_DISCARD,e:GetHandler())
end
function c77714963.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c77714963.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c77714963.sslimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsLocation(LOCATION_EXTRA) and not c:IsSetCard(0x121)
end
