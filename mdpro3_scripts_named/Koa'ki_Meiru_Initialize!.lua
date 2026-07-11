--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Koa'ki Meiru Initialize!  (ID: 91985515)
-- Type: Spell / Quick-Play
-- Setcode: 0x1d
-- Scope: OCG / TCG
--
-- Effect Text:
-- Tribute 1 "Koa'ki Meiru" monster to add 1 "Iron Core of Koa'ki Meiru" from your Deck or Graveyard to
-- your hand.
--[[ __CARD_HEADER_END__ ]]

--鋼核初期化
function c91985515.initial_effect(c)
	aux.AddCodeList(c,36623431)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c91985515.cost)
	e1:SetTarget(c91985515.target)
	e1:SetOperation(c91985515.activate)
	c:RegisterEffect(e1)
end
function c91985515.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,nil,0x1d) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,nil,0x1d)
	Duel.Release(g,REASON_COST)
end
function c91985515.filter(c)
	return c:IsCode(36623431) and c:IsAbleToHand()
end
function c91985515.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c91985515.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c91985515.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c91985515.filter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
