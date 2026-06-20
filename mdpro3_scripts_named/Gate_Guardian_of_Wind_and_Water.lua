--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 风水魔神-门之守护神  (ID: 61398234)
-- Type: Monster / Effect / Fusion
-- Attribute: WIND
-- Race: Spellcaster
-- Level 9
-- ATK 2450 | DEF 2300
-- Setcode: 4178
--
-- Effect Text:
-- 「风魔神-修迦」＋「水魔神-斯迦」
-- 把自己场上的上记的卡除外的场合才能特殊召唤。这个卡名的①的效果1回合可以使用最多2次。
-- ①：对方把场上的魔法·陷阱卡的效果发动时才能发动（同一连锁上最多1次）。那个效果无效。
-- ②：特殊召唤的表侧表示的这张卡因对方从场上离开的场合才能发动。自己的除外状态的1只「风魔神-修迦」或「水魔神-斯迦」特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--風水魔神－ゲート・ガーディアン
function c61398234.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,62340868,98434877,true,true)
	aux.AddContactFusionProcedure(c,Card.IsAbleToRemoveAsCost,LOCATION_ONFIELD,0,Duel.Remove,POS_FACEUP,REASON_COST)
	--spsummon condition
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e0)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(61398234,1))
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(2,61398234)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c61398234.discon)
	e1:SetTarget(c61398234.distg)
	e1:SetOperation(c61398234.disop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(61398234,2))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCondition(c61398234.spcon)
	e2:SetTarget(c61398234.sptg)
	e2:SetOperation(c61398234.spop)
	c:RegisterEffect(e2)
end
function c61398234.discon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and re:IsActiveType(TYPE_SPELL+TYPE_TRAP)
		and ((re:GetActivateLocation()&LOCATION_ONFIELD)>0 or re:IsHasType(EFFECT_TYPE_ACTIVATE))
		and Duel.IsChainDisablable(ev)
end
function c61398234.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(61398234)==0 end
	c:RegisterFlagEffect(61398234,RESET_CHAIN,0,1)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c61398234.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
function c61398234.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsSummonType(SUMMON_TYPE_SPECIAL) and c:IsPreviousLocation(LOCATION_MZONE)
		and c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousControler(tp) and c:GetReasonPlayer()==1-tp
end
function c61398234.spfilter(c,e,tp)
	return c:IsCode(62340868,98434877) and c:IsFaceup() and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c61398234.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c61398234.spfilter,tp,LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_REMOVED)
end
function c61398234.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c61398234.spfilter,tp,LOCATION_REMOVED,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
