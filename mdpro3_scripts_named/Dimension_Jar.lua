--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Dimension Jar  (ID: 73414375)
-- Type: Monster / Effect / Flip
-- Attribute: DARK
-- Race: Machine
-- Level: 2
-- ATK 200 | DEF 200
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: Both players can remove from play up to 3 monsters from their opponent's Graveyard.
--[[ __CARD_HEADER_END__ ]]

--ディメンション・ポッド
function c73414375.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(73414375,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c73414375.target)
	e1:SetOperation(c73414375.operation)
	c:RegisterEffect(e1)
end
function c73414375.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c73414375.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	if Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(73414375,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local rg=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,3,nil)
		g:Merge(rg)
	end
	if Duel.IsExistingMatchingCard(Card.IsAbleToRemove,1-tp,0,LOCATION_GRAVE,1,nil,1-tp) and Duel.SelectYesNo(1-tp,aux.Stringid(73414375,1)) then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_REMOVE)
		local rg=Duel.SelectMatchingCard(1-tp,Card.IsAbleToRemove,1-tp,0,LOCATION_GRAVE,1,3,nil,1-tp)
		g:Merge(rg)
	end
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end
