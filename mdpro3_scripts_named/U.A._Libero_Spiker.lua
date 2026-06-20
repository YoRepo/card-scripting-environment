--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 超级运动员 自由人攻手  (ID: 11637481)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1800 | DEF 1800
-- Setcode: 178
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次，②的效果1回合只能使用1次。
-- ①：这张卡可以让「超级运动员 自由人攻手」以外的自己场上1只「超级运动员」怪兽回到手卡，从手卡特殊召唤。
-- ②：对方主要阶段才能发动。手卡1只5星以上的「超级运动员」怪兽回到卡组，和那只怪兽卡名不同的1只「超级运动员」怪兽从卡组特殊召唤。那之后，场上的这张卡回到持有者手卡。
--[[ __CARD_HEADER_END__ ]]

--U.A.リベロスパイカー
function c11637481.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11637481,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,11637481+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c11637481.spcon)
	e1:SetTarget(c11637481.sptg)
	e1:SetOperation(c11637481.spop)
	c:RegisterEffect(e1)
	--special summon from deck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(11637481,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,11637482)
	e2:SetCondition(c11637481.spcon2)
	e2:SetTarget(c11637481.sptg2)
	e2:SetOperation(c11637481.spop2)
	c:RegisterEffect(e2)
end
function c11637481.spfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0xb2) and not c:IsCode(11637481) and c:IsAbleToHandAsCost()
		and Duel.GetMZoneCount(tp,c)>0
end
function c11637481.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c11637481.spfilter,tp,LOCATION_MZONE,0,1,nil,tp)
end
function c11637481.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c11637481.spfilter,tp,LOCATION_MZONE,0,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c11637481.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.SendtoHand(g,nil,REASON_SPSUMMON)
end
function c11637481.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
end
function c11637481.spfilter1(c,e,tp)
	return c:IsSetCard(0xb2) and c:IsLevelAbove(5) and c:IsAbleToDeck()
		and Duel.IsExistingMatchingCard(c11637481.spfilter2,tp,LOCATION_DECK,0,1,nil,e,tp,c)
end
function c11637481.spfilter2(c,e,tp,tc)
	return c:IsSetCard(0xb2) and not c:IsCode(tc:GetCode()) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c11637481.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsAbleToHand()
		and Duel.IsExistingMatchingCard(c11637481.spfilter1,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c11637481.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g1=Duel.GetMatchingGroup(c11637481.spfilter1,tp,LOCATION_HAND,0,nil,e,tp)
	if g1:GetCount()<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local tg1=g1:Select(tp,1,1,nil)
	Duel.ConfirmCards(1-tp,tg1)
	if Duel.SendtoDeck(tg1,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g2=Duel.SelectMatchingCard(tp,c11637481.spfilter2,tp,LOCATION_DECK,0,1,1,nil,e,tp,tg1:GetFirst())
		if Duel.SpecialSummon(g2,0,tp,tp,false,false,POS_FACEUP) and e:GetHandler():IsRelateToEffect(e) then
			Duel.BreakEffect()
			Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
		end
	end
end
