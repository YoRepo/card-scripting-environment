--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Edge Imp Sabres  (ID: 30068120)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 3
-- ATK 1200 | DEF 800
-- Setcode: 0xc3
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is in your GY: You can place 1 card from your hand on the top of the Deck; Special
-- Summon this card in Defense Position.
-- You can only use this effect of "Edge Imp Sabres" once per turn.
--[[ __CARD_HEADER_END__ ]]

--エッジインプ・シザー
function c30068120.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(30068120,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,30068120)
	e1:SetCost(c30068120.cost)
	e1:SetTarget(c30068120.target)
	e1:SetOperation(c30068120.operation)
	c:RegisterEffect(e1)
end
function c30068120.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeckAsCost,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeckAsCost,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoDeck(g,nil,SEQ_DECKTOP,REASON_COST)
end
function c30068120.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c30068120.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
