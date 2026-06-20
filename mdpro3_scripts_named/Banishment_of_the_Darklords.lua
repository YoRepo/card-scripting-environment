--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 堕天使的追放  (ID: 87112784)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 239
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从卡组把「堕天使的追放」以外的1张「堕天使」卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--堕天使の追放
function c87112784.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,87112784+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c87112784.target)
	e1:SetOperation(c87112784.activate)
	c:RegisterEffect(e1)
end
function c87112784.filter(c)
	return c:IsSetCard(0xef) and not c:IsCode(87112784) and c:IsAbleToHand()
end
function c87112784.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c87112784.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c87112784.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c87112784.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
