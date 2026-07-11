--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Brotherhood of the Fire Fist - Cardinal  (ID: 58504745)
-- Type: Monster / Effect / Xyz
-- Attribute: FIRE
-- Race: Beast-Warrior
-- Rank: 4
-- ATK 1800 | DEF 2200
-- Setcode: 0x79
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Level 4 "Fire Fist" monsters
-- You can detach 2 materials from this card, then target 2 "Fire Fist" / "Fire Formation" cards in
-- your GY and/or face-up field, and 2 cards in your opponent's GY and/or face-up field; shuffle those
-- targets into the Deck.
-- You can only use this effect of "Brotherhood of the Fire Fist - Cardinal" once per turn.
--[[ __CARD_HEADER_END__ ]]

--間炎星－コウカンショウ
function c58504745.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x79),4,2)
	c:EnableReviveLimit()
	--todeck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(58504745,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,58504745)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c58504745.cost)
	e1:SetTarget(c58504745.target)
	e1:SetOperation(c58504745.operation)
	c:RegisterEffect(e1)
end
function c58504745.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,2,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c58504745.filter1(c)
	return (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup()) and c:IsSetCard(0x79,0x7c) and c:IsAbleToDeck()
end
function c58504745.filter2(c)
	return (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup()) and c:IsAbleToDeck()
end
function c58504745.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c58504745.filter1,tp,LOCATION_GRAVE+LOCATION_ONFIELD,0,2,nil)
		and Duel.IsExistingTarget(c58504745.filter2,tp,0,LOCATION_GRAVE+LOCATION_ONFIELD,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g1=Duel.SelectTarget(tp,c58504745.filter1,tp,LOCATION_GRAVE+LOCATION_ONFIELD,0,2,2,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g2=Duel.SelectTarget(tp,c58504745.filter2,tp,0,LOCATION_GRAVE+LOCATION_ONFIELD,2,2,nil)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g1,4,0,0)
end
function c58504745.filter3(c,e)
	return (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup()) and c:IsRelateToEffect(e)
end
function c58504745.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c58504745.filter3,nil,e)
	Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
end
