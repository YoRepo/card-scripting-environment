--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 天威无双之拳  (ID: 21834870)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
-- Setcode: 300
--
-- Effect Text:
-- ①：自己场上有效果怪兽以外的表侧表示怪兽存在，怪兽的效果·魔法·陷阱卡发动时才能发动。那个发动无效。
-- ②：盖放的这张卡被对方的效果破坏的场合才能发动。从额外卡组把效果怪兽以外的1只怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--天威無双の拳
function c21834870.initial_effect(c)
	--Activate(effect)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21834870,0))
	e1:SetCategory(CATEGORY_NEGATE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c21834870.condition)
	e1:SetTarget(c21834870.target)
	e1:SetOperation(c21834870.operation)
	c:RegisterEffect(e1)
	--return
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21834870,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCondition(c21834870.spcon)
	e2:SetTarget(c21834870.sptg)
	e2:SetOperation(c21834870.spop)
	c:RegisterEffect(e2)
end
function c21834870.cfilter(c)
	return c:IsFaceup() and not c:IsType(TYPE_EFFECT)
end
function c21834870.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c21834870.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE))
		and Duel.IsChainNegatable(ev)
end
function c21834870.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c21834870.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
end
function c21834870.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return rp==1-tp and c:IsReason(REASON_EFFECT) and c:IsPreviousControler(tp)
		and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEDOWN)
end
function c21834870.spfilter(c,e,tp)
	return not c:IsType(TYPE_EFFECT) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function c21834870.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21834870.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c21834870.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.SelectMatchingCard(tp,c21834870.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if tg:GetCount()>0 then
		Duel.SpecialSummon(tg,0,tp,tp,false,false,POS_FACEUP)
	end
end
