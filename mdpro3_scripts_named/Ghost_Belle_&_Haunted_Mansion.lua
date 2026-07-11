--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Ghost Belle & Haunted Mansion  (ID: 73642296)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Zombie
-- Level: 3
-- ATK 0 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a card or effect is activated that includes any of these effects (Quick Effect): You can
-- discard this card; negate that activation.
-- ● Add a card(s) from the GY to the hand, Deck, and/or Extra Deck.
-- ● Special Summon a Monster Card(s) from the GY.
-- ● Banish a card(s) from the GY.
-- You can only use this effect of "Ghost Belle & Haunted Mansion" once per turn.
--[[ __CARD_HEADER_END__ ]]

--屋敷わらし
function c73642296.initial_effect(c)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(73642296,0))
	e1:SetCategory(CATEGORY_NEGATE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,73642296)
	e1:SetCondition(c73642296.discon)
	e1:SetCost(c73642296.discost)
	e1:SetTarget(c73642296.distg)
	e1:SetOperation(c73642296.disop)
	c:RegisterEffect(e1)
end
function c73642296.cfilter(c)
	return c:IsLocation(LOCATION_GRAVE) and c:IsType(TYPE_MONSTER)
end
function c73642296.discon(e,tp,eg,ep,ev,re,r,rp)
	local ex1,g1,gc1,dp1,dv1=Duel.GetOperationInfo(ev,CATEGORY_TOHAND)
	local ex2,g2,gc2,dp2,dv2=Duel.GetOperationInfo(ev,CATEGORY_TODECK)
	local ex3,g3,gc3,dp3,dv3=Duel.GetOperationInfo(ev,CATEGORY_TOEXTRA)
	local ex4,g4,gc4,dp4,dv4=Duel.GetOperationInfo(ev,CATEGORY_SPECIAL_SUMMON)
	local ex5,g5,gc5,dp5,dv5=Duel.GetOperationInfo(ev,CATEGORY_REMOVE)
	return ((ex1 and (dv1&LOCATION_GRAVE==LOCATION_GRAVE or g1 and g1:IsExists(Card.IsLocation,1,nil,LOCATION_GRAVE)))
		or (ex2 and (dv2&LOCATION_GRAVE==LOCATION_GRAVE or g2 and g2:IsExists(Card.IsLocation,1,nil,LOCATION_GRAVE)))
		or (ex3 and (dv3&LOCATION_GRAVE==LOCATION_GRAVE or g3 and g3:IsExists(Card.IsLocation,1,nil,LOCATION_GRAVE)))
		or (ex4 and (dv4&LOCATION_GRAVE==LOCATION_GRAVE or g4 and g4:IsExists(c73642296.cfilter,1,nil)))
		or (ex5 and (dv5&LOCATION_GRAVE==LOCATION_GRAVE or g5 and g5:IsExists(Card.IsLocation,1,nil,LOCATION_GRAVE)))
		or re:IsHasCategory(CATEGORY_GRAVE_SPSUMMON)
		or re:IsHasCategory(CATEGORY_GRAVE_ACTION))
		and Duel.IsChainNegatable(ev)
end
function c73642296.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c73642296.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c73642296.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
end
