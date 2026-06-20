--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 北极天熊-小白熊  (ID: 29537493)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Beast
-- Level 7
-- ATK 700 | DEF 2000
-- Setcode: 355
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己·对方的主要阶段，从手卡把这张卡以外的1只7星以上的怪兽解放才能发动。这张卡从手卡特殊召唤。这个效果的发动后，直到回合结束时自己若非持有等级的怪兽则不能特殊召唤。
-- ②：这张卡特殊召唤成功的场合才能发动。从卡组把「北极天熊-小白熊」以外的1只「北极天熊」怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ベアルクティ－ミクポーラ
function c29537493.initial_effect(c)
	--special summon
	local e1=aux.AddUrsarcticSpSummonEffect(c)
	e1:SetDescription(aux.Stringid(29537493,0))
	e1:SetCountLimit(1,29537493)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(29537493,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,29537494)
	e2:SetTarget(c29537493.thtg)
	e2:SetOperation(c29537493.thop)
	c:RegisterEffect(e2)
end
function c29537493.thfilter(c)
	return c:IsSetCard(0x163) and c:IsType(TYPE_MONSTER) and not c:IsCode(29537493) and c:IsAbleToHand()
end
function c29537493.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c29537493.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c29537493.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c29537493.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
