--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Fairy Knight Ingunar  (ID: 19684740)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Plant
-- Rank: 6
-- ATK 2200 | DEF 3000
-- Scope: OCG / TCG
--
-- Effect Text:
-- 3 Level 6 monsters
-- Once per turn: You can detach 2 Xyz Materials from this card; return all other cards on the field to
-- the hand.
-- Your opponent cannot activate cards or effects in response to this effect's activation.
--[[ __CARD_HEADER_END__ ]]

--妖精騎士イングナル
function c19684740.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,6,3)
	c:EnableReviveLimit()
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(19684740,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c19684740.thcost)
	e1:SetTarget(c19684740.thtg)
	e1:SetOperation(c19684740.thop)
	c:RegisterEffect(e1)
end
function c19684740.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,2,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c19684740.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
	Duel.SetChainLimit(c19684740.chlimit)
end
function c19684740.chlimit(e,ep,tp)
	return tp==ep
end
function c19684740.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,aux.ExceptThisCard(e))
	Duel.SendtoHand(g,nil,REASON_EFFECT)
end
