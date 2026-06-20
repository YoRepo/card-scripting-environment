--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 随风旅鸟与旅行准备  (ID: 69087397)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 365
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从手卡以及自己场上的表侧表示怪兽之中把1只鸟兽族怪兽除外才能发动。从卡组把1只「随风旅鸟」怪兽或者1张「随风旅鸟」场地魔法卡加入手卡。那之后，自己回复500基本分。
--[[ __CARD_HEADER_END__ ]]

--ふわんだりぃずと旅じたく
function c69087397.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,69087397+EFFECT_COUNT_CODE_OATH)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCost(c69087397.cost)
	e1:SetTarget(c69087397.target)
	e1:SetOperation(c69087397.activate)
	c:RegisterEffect(e1)
end
function c69087397.cfilter(c)
	return c:IsRace(RACE_WINDBEAST) and (c:IsFaceup() or c:IsLocation(LOCATION_HAND)) and c:IsAbleToRemoveAsCost()
end
function c69087397.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c69087397.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c69087397.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c69087397.thfilter(c)
	return (c:IsSetCard(0x16d) and c:IsType(TYPE_MONSTER) or c:IsSetCard(0x16d) and c:IsType(TYPE_FIELD)) and c:IsAbleToHand()
end
function c69087397.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c69087397.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(500)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,500)
end
function c69087397.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c69087397.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		Duel.BreakEffect()
		Duel.Recover(tp,500,REASON_EFFECT)
	end
end
