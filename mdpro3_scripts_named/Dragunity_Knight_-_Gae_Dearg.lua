--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 龙骑兵团骑士-赤枪龙骑士  (ID: 34116027)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Dragon
-- Level 6
-- ATK 2400 | DEF 800
-- Setcode: 41
--
-- Effect Text:
-- 龙族调整＋调整以外的鸟兽族怪兽1只以上
-- ①：1回合1次，自己主要阶段才能发动。从卡组把1只4星以下的龙族·鸟兽族怪兽加入手卡。那之后，从手卡选1只龙族·鸟兽族怪兽丢弃。
--[[ __CARD_HEADER_END__ ]]

--ドラグニティナイト－ガジャルグ
function c34116027.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_DRAGON),aux.NonTuner(Card.IsRace,RACE_WINDBEAST),1)
	c:EnableReviveLimit()
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(34116027,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c34116027.target)
	e1:SetOperation(c34116027.operation)
	c:RegisterEffect(e1)
end
function c34116027.filter(c)
	return c:IsLevelBelow(4) and c:IsRace(RACE_DRAGON+RACE_WINDBEAST) and c:IsAbleToHand()
end
function c34116027.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c34116027.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,1,tp,1)
end
function c34116027.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c34116027.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoHand(g,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
	Duel.BreakEffect()
	Duel.DiscardHand(tp,Card.IsRace,1,1,REASON_EFFECT+REASON_DISCARD,nil,RACE_DRAGON+RACE_WINDBEAST)
end
