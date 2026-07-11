--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: The Stern Mystic  (ID: 87557188)
-- Type: Monster / Effect / Flip
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level: 4
-- ATK 1500 | DEF 1200
-- Setcode: 0x98
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: Reveal all face-down cards on the field (Flip Effects are not activated), then return them to
-- their original positions.
--[[ __CARD_HEADER_END__ ]]

--厳格な老魔術師
function c87557188.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c87557188.target)
	e1:SetOperation(c87557188.activate)
	c:RegisterEffect(e1)
end
function c87557188.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,nil) end
end
function c87557188.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_ONFIELD,nil)
	if g:GetCount()>0 then
		Duel.ConfirmCards(tp,g)
	end
end
