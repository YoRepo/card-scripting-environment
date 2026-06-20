--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 邪帝家臣 卢基乌斯  (ID: 58786132)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 1
-- ATK 800 | DEF 1000
--
-- Effect Text:
-- 「邪帝家臣 卢基乌斯」的①②的效果1回合各能使用1次。
-- ①：把自己墓地1只5星以上的怪兽除外才能发动。这张卡从手卡特殊召唤。这个回合，自己不能从额外卡组把怪兽特殊召唤。
-- ②：这张卡为上级召唤而被解放的场合才能发动。对方场上盖放的卡全部确认。对方不能对应这个效果的发动把魔法·陷阱·怪兽的效果发动。
--[[ __CARD_HEADER_END__ ]]

--邪帝家臣ルキウス
function c58786132.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,58786132)
	e1:SetCost(c58786132.spcost)
	e1:SetTarget(c58786132.sptg)
	e1:SetOperation(c58786132.spop)
	c:RegisterEffect(e1)
	--confirm
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_RELEASE)
	e2:SetCountLimit(1,58786133)
	e2:SetCondition(c58786132.condition)
	e2:SetTarget(c58786132.target)
	e2:SetOperation(c58786132.operation)
	c:RegisterEffect(e2)
end
function c58786132.cfilter(c)
	return c:IsLevelAbove(5) and c:IsAbleToRemoveAsCost()
end
function c58786132.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c58786132.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c58786132.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c58786132.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c58786132.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c58786132.splimit)
	Duel.RegisterEffect(e1,tp)
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c58786132.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsLocation(LOCATION_EXTRA)
end
function c58786132.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_SUMMON)
end
function c58786132.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.SetChainLimit(c58786132.chlimit)
end
function c58786132.chlimit(e,ep,tp)
	return tp==ep
end
function c58786132.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_ONFIELD,nil)
	Duel.ConfirmCards(tp,g)
end
