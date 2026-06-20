--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 剑斗训练所  (ID: 35224440)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 25
--
-- Effect Text:
-- 从自己卡组把1只4星以下的名字带有「剑斗兽」的怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--剣闘訓練所
function c35224440.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c35224440.target)
	e1:SetOperation(c35224440.activate)
	c:RegisterEffect(e1)
end
function c35224440.filter(c)
	return c:IsSetCard(0x1019) and c:IsLevelBelow(4) and c:IsAbleToHand()
end
function c35224440.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c35224440.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c35224440.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c35224440.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
