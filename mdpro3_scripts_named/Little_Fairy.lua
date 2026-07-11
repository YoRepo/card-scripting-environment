--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Little Fairy  (ID: 45939611)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 3
-- ATK 800 | DEF 800
-- Scope: OCG / TCG
--
-- Effect Text:
-- Up to twice per turn: You can send 1 card from your hand to the Graveyard; increase this card's
-- Level by 1.
--[[ __CARD_HEADER_END__ ]]

--リトル・フェアリー
function c45939611.initial_effect(c)
	--lvup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(45939611,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(2)
	e1:SetCost(c45939611.cost)
	e1:SetOperation(c45939611.operation)
	c:RegisterEffect(e1)
end
function c45939611.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsAbleToGraveAsCost,1,1,REASON_COST)
end
function c45939611.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
