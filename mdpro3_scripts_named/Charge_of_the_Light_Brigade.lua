--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 光之援军  (ID: 94886282)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：从自己卡组上面把3张卡送去墓地才能发动。从卡组把1只4星以下的「光道」怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--光の援軍
function c94886282.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c94886282.cost)
	e1:SetTarget(c94886282.target)
	e1:SetOperation(c94886282.activate)
	c:RegisterEffect(e1)
end
function c94886282.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeckAsCost(tp,3) end
	Duel.DiscardDeck(tp,3,REASON_COST)
end
function c94886282.filter(c)
	return c:IsSetCard(0x38) and c:IsLevelBelow(4) and c:IsAbleToHand()
end
function c94886282.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c94886282.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c94886282.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c94886282.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
