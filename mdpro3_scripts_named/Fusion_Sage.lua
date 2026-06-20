--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 融合贤者  (ID: 26902560)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 70
--
-- Effect Text:
-- 选1张自己的卡组的「融合」加入手卡。之后洗切卡组。
--[[ __CARD_HEADER_END__ ]]

--融合賢者
function c26902560.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c26902560.target)
	e1:SetOperation(c26902560.activate)
	c:RegisterEffect(e1)
end
function c26902560.filter(c)
	return c:IsCode(24094653) and c:IsAbleToHand()
end
function c26902560.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c26902560.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c26902560.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c26902560.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
