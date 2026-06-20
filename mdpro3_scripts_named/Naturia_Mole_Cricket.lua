--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 自然蝼蛄  (ID: 93454062)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level 1
-- ATK 0 | DEF 0
-- Setcode: 42
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己·对方的主要阶段，把这张卡解放才能发动。从卡组把1只「自然」怪兽特殊召唤。攻击力最高的怪兽在对方场上存在的场合，这个效果特殊召唤的数量可以变成2只。
-- ②：这张卡在墓地存在的状态，对方从额外卡组把怪兽特殊召唤的场合或者自己从额外卡组把「自然」怪兽特殊召唤的场合才能发动。这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ナチュル・モルクリケット
function c93454062.initial_effect(c)
	--same effect send this card to grave and spsummon another card check
	local e0=aux.AddThisCardInGraveAlreadyCheck(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(93454062,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e1:SetCountLimit(1,93454062)
	e1:SetCondition(c93454062.spcon)
	e1:SetCost(c93454062.spcost)
	e1:SetTarget(c93454062.sptg)
	e1:SetOperation(c93454062.spop)
	c:RegisterEffect(e1)
	--revive
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(93454062,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,93454063)
	e2:SetLabelObject(e0)
	e2:SetCondition(c93454062.rvcon)
	e2:SetTarget(c93454062.rvtg)
	e2:SetOperation(c93454062.rvop)
	c:RegisterEffect(e2)
end
function c93454062.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c93454062.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local fe=Duel.IsPlayerAffectedByEffect(tp,29942771)
	local b1=fe and Duel.IsPlayerCanDiscardDeckAsCost(tp,2) and Duel.GetMZoneCount(tp)>0
	local b2=c:IsReleasable() and Duel.GetMZoneCount(tp,c)>0
	if chk==0 then return b1 or b2 end
	if b1 and (not b2 or Duel.SelectYesNo(tp,fe:GetDescription())) then
		Duel.Hint(HINT_CARD,0,29942771)
		fe:UseCountLimit(tp)
		Duel.DiscardDeck(tp,2,REASON_COST)
	else
		Duel.Release(c,REASON_COST)
	end
end
function c93454062.spfilter(c,e,tp)
	return c:IsSetCard(0x2a) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c93454062.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c93454062.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c93454062.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tg=g:GetMaxGroup(Card.GetAttack)
	if ft>=2 and not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and tg and tg:IsExists(Card.IsControler,1,nil,1-tp) then
		ft=2
	else
		ft=1
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c93454062.spfilter,tp,LOCATION_DECK,0,1,ft,nil,e,tp)
	if sg:GetCount()>0 then
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c93454062.cfilter(c,tp,se)
	return (c:IsSummonPlayer(1-tp) or c:IsSetCard(0x2a)) and c:IsSummonLocation(LOCATION_EXTRA)
		and (se==nil or c:GetReasonEffect()~=se)
end
function c93454062.rvcon(e,tp,eg,ep,ev,re,r,rp)
	local se=e:GetLabelObject():GetLabelObject()
	return eg:IsExists(c93454062.cfilter,1,nil,tp,se)
end
function c93454062.rvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c93454062.rvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
