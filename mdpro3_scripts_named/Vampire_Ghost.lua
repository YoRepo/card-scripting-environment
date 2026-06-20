--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 吸血鬼的幽鬼  (ID: 90299015)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 3
-- ATK 1500 | DEF 0
-- Setcode: 142
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡召唤成功的场合，从手卡以及自己场上的表侧表示的卡之中把这张卡以外的1张「吸血鬼」卡送去墓地才能发动。从卡组把1只4星以上的「吸血鬼」怪兽加入手卡，从卡组把1只2星以下的「吸血鬼」怪兽送去墓地
-- 。
-- ②：自己·对方的主要阶段，把墓地的这张卡除外，支付500基本分才能发动。把1只「吸血鬼」怪兽召唤。
--[[ __CARD_HEADER_END__ ]]

--ヴァンパイアの幽鬼
function c90299015.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,90299015)
	e1:SetCost(c90299015.thcost)
	e1:SetTarget(c90299015.thtg)
	e1:SetOperation(c90299015.thop)
	c:RegisterEffect(e1)
	--summon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e2:SetCountLimit(1,90299016)
	e2:SetCondition(c90299015.sumcon)
	e2:SetCost(c90299015.sumcost)
	e2:SetTarget(c90299015.sumtg)
	e2:SetOperation(c90299015.sumop)
	c:RegisterEffect(e2)
end
function c90299015.costfilter(c)
	return c:IsSetCard(0x8e) and c:IsAbleToGraveAsCost() and (c:IsLocation(LOCATION_HAND) or c:IsFaceup())
end
function c90299015.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90299015.costfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c90299015.costfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
end
function c90299015.filter1(c)
	return c:IsSetCard(0x8e) and c:IsLevelAbove(4) and c:IsAbleToHand()
end
function c90299015.filter2(c)
	return c:IsSetCard(0x8e) and c:IsLevelBelow(2) and c:IsAbleToGrave()
end
function c90299015.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90299015.filter1,tp,LOCATION_DECK,0,1,nil)
		and Duel.IsExistingMatchingCard(c90299015.filter2,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c90299015.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g1=Duel.SelectMatchingCard(tp,c90299015.filter1,tp,LOCATION_DECK,0,1,1,nil)
	if g1:GetCount()>0 then
		Duel.SendtoHand(g1,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g1)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g2=Duel.SelectMatchingCard(tp,c90299015.filter2,tp,LOCATION_DECK,0,1,1,nil)
		if g2:GetCount()>0 then
			Duel.SendtoGrave(g2,REASON_EFFECT)
		end
	end
end
function c90299015.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c90299015.sumcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() and Duel.CheckLPCost(tp,500) end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
	Duel.PayLPCost(tp,500)
end
function c90299015.sumfilter(c)
	return c:IsSetCard(0x8e) and c:IsSummonable(true,nil)
end
function c90299015.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90299015.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c90299015.sumop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c90299015.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.Summon(tp,tc,true,nil)
	end
end
