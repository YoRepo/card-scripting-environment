--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 熔岩谷龙骑士  (ID: 8611007)
-- Type: Monster / Effect / Synchro
-- Attribute: FIRE
-- Race: Dragon
-- Level 6
-- ATK 2500 | DEF 1200
-- Setcode: 57
--
-- Effect Text:
-- 调整＋调整以外的炎属性怪兽1只以上
-- ①：1回合1次，自己主要阶段才能发动。从卡组把1只「熔岩」怪兽加入手卡。那之后，从手卡选1只「熔岩」怪兽送去墓地。
--[[ __CARD_HEADER_END__ ]]

--ラヴァルバル・ドラグーン
function c8611007.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsAttribute,ATTRIBUTE_FIRE),1)
	c:EnableReviveLimit()
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(8611007,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c8611007.target)
	e1:SetOperation(c8611007.operation)
	c:RegisterEffect(e1)
end
function c8611007.filter(c)
	return c:IsSetCard(0x39) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c8611007.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c8611007.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND)
end
function c8611007.tgfilter(c)
	return c:IsSetCard(0x39) and c:IsType(TYPE_MONSTER)
end
function c8611007.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c8611007.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoHand(g,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
	Duel.BreakEffect()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local dg=Duel.SelectMatchingCard(tp,c8611007.tgfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(dg,REASON_EFFECT)
end
