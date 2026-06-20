--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 转生炎兽 狐獴  (ID: 67225377)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Cyberse
-- Level 2
-- ATK 800 | DEF 600
-- Setcode: 281
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡用通常抽卡以外的方法加入手卡的场合，把这张卡给对方观看才能发动。这张卡从手卡特殊召唤。
-- ②：从手卡把这张卡以外的1张「转生炎兽」卡丢弃才能发动。这张卡从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--転生炎獣ミーア
function c67225377.initial_effect(c)
	--special summon (to hand)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(67225377,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_HAND)
	e1:SetCountLimit(1,67225377)
	e1:SetCondition(c67225377.spcon)
	e1:SetCost(c67225377.spcost1)
	e1:SetTarget(c67225377.sptg1)
	e1:SetOperation(c67225377.spop1)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(67225377,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,67225378)
	e2:SetCost(c67225377.spcost2)
	e2:SetTarget(c67225377.sptg2)
	e2:SetOperation(c67225377.spop2)
	c:RegisterEffect(e2)
end
function c67225377.spcon(e,tp,eg,ep,ev,re,r,rp)
	return not (r==REASON_RULE)
end
function c67225377.spcost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsPublic() end
end
function c67225377.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c67225377.spop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c67225377.cfilter(c)
	return c:IsSetCard(0x119) and c:IsDiscardable()
end
function c67225377.spcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c67225377.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c67225377.cfilter,1,1,REASON_COST+REASON_DISCARD,e:GetHandler())
end
function c67225377.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c67225377.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
