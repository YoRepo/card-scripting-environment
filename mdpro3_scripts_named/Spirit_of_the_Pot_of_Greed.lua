--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Spirit of the Pot of Greed  (ID: 4896788)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 1
-- ATK 100 | DEF 100
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a player activates "Pot of Greed": Activate this effect; they can draw 1 card.
-- This card must be in face-up Attack Position to activate and to resolve this effect.
--[[ __CARD_HEADER_END__ ]]

--強欲な壺の精霊
function c4896788.initial_effect(c)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_ACTIVATE_CONDITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c4896788.drcon)
	e2:SetOperation(c4896788.drop)
	c:RegisterEffect(e2)
end
function c4896788.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsAttackPos()
		and re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetHandler():IsCode(55144522)
end
function c4896788.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsAttackPos() or not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.IsPlayerCanDraw(rp,1) and Duel.SelectYesNo(rp,aux.Stringid(4896788,0)) then
		Duel.Draw(rp,1,REASON_EFFECT)
	end
end
