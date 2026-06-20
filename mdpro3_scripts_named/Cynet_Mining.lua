--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 电脑网挖矿  (ID: 57160136)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 280
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：把1张手卡送去墓地才能发动。从卡组把1只4星以下的电子界族怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--サイバネット・マイニング
function c57160136.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,57160136+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c57160136.cost)
	e1:SetTarget(c57160136.target)
	e1:SetOperation(c57160136.activate)
	c:RegisterEffect(e1)
end
function c57160136.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsAbleToGraveAsCost,1,1,REASON_COST)
end
function c57160136.filter(c)
	return c:IsLevelBelow(4) and c:IsRace(RACE_CYBERSE) and c:IsAbleToHand()
end
function c57160136.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c57160136.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c57160136.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c57160136.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
