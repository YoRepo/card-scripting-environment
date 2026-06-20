--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 卡尔塔罗斯异虫  (ID: 51043243)
-- Type: Monster / Effect / Toon
-- Attribute: LIGHT
-- Race: Reptile
-- Level 4
-- ATK 1200 | DEF 500
-- Setcode: 62
--
-- Effect Text:
-- 反转：从自己卡组把1只4星以下的名字带有「异虫」的爬虫类族怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ワーム・カルタロス
function c51043243.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_FLIP+EFFECT_TYPE_SINGLE)
	e1:SetTarget(c51043243.tg)
	e1:SetOperation(c51043243.op)
	c:RegisterEffect(e1)
end
function c51043243.filter(c)
	return c:IsLevelBelow(4) and c:IsSetCard(0x3e) and c:IsRace(RACE_REPTILE) and c:IsAbleToHand()
end
function c51043243.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c51043243.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c51043243.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
