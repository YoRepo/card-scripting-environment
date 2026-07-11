--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Reshef the Dark Being  (ID: 62420419)
-- Type: Monster / Effect / Ritual
-- Attribute: LIGHT
-- Race: Fiend
-- Level: 8
-- ATK 2500 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can only be Ritual Summoned with the Ritual Spell Card, "Final Ritual of the Ancients".
-- Once per turn, by discarding 1 Spell Card from your hand, take control of 1 monster on your
-- opponent's side of the field until the end of this turn.
--[[ __CARD_HEADER_END__ ]]

--大邪神 レシェフ
function c62420419.initial_effect(c)
	aux.AddCodeList(c,60369732)
	c:EnableReviveLimit()
	--control
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(62420419,0))
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c62420419.cost)
	e1:SetTarget(c62420419.target)
	e1:SetOperation(c62420419.operation)
	c:RegisterEffect(e1)
end
function c62420419.cfilter(c)
	return c:IsDiscardable() and c:IsType(TYPE_SPELL)
end
function c62420419.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c62420419.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c62420419.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c62420419.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsControlerCanBeChanged() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c62420419.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.GetControl(tc,tp,PHASE_END,1)
	end
end
