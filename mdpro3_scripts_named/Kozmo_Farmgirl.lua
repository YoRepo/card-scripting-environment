--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 星际仙踪-多萝塞尔  (ID: 31061682)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Psychic
-- Level 3
-- ATK 1500 | DEF 1000
-- Setcode: 210
--
-- Effect Text:
-- 「星际仙踪-多萝塞尔」的①的效果1回合只能使用1次。
-- ①：把场上的这张卡除外才能发动。从手卡把1只4星以上的「星际仙踪」怪兽特殊召唤。这个效果在对方回合也能发动。
-- ②：这张卡给与对方战斗伤害时，支付500基本分才能发动。从卡组把1张「星际仙踪」卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--Kozmo－ドロッセル
function c31061682.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31061682,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,31061682)
	e1:SetCost(c31061682.spcost)
	e1:SetTarget(c31061682.sptg)
	e1:SetOperation(c31061682.spop)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCondition(c31061682.thcon)
	e2:SetCost(c31061682.thcost)
	e2:SetTarget(c31061682.thtg)
	e2:SetOperation(c31061682.thop)
	c:RegisterEffect(e2)
end
function c31061682.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c31061682.spfilter(c,e,tp)
	return c:IsSetCard(0xd2) and c:IsLevelAbove(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c31061682.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c31061682.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c31061682.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c31061682.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c31061682.thcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c31061682.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c31061682.thfilter(c)
	return c:IsSetCard(0xd2) and c:IsAbleToHand()
end
function c31061682.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c31061682.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c31061682.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c31061682.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
