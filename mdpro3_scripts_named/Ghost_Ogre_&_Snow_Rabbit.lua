--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Ghost Ogre & Snow Rabbit  (ID: 59438930)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Psychic
-- Level: 3
-- ATK 0 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a monster on the field activates its effect, or when a Spell/Trap that is already face-up on
-- the field activates its effect (Quick Effect): You can send this card from your hand or field to the
-- GY; destroy that card on the field.
-- You can only use this effect of "Ghost Ogre & Snow Rabbit" once per turn.
--[[ __CARD_HEADER_END__ ]]

--幽鬼うさぎ
function c59438930.initial_effect(c)
	--double
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE+LOCATION_HAND)
	e1:SetCountLimit(1,59438930)
	e1:SetCondition(c59438930.condition)
	e1:SetCost(c59438930.cost)
	e1:SetTarget(c59438930.target)
	e1:SetOperation(c59438930.operation)
	c:RegisterEffect(e1)
end
function c59438930.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:GetHandler():IsOnField() and re:GetHandler():IsRelateToEffect(re) and (re:IsActiveType(TYPE_MONSTER)
		or (re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and not re:IsHasType(EFFECT_TYPE_ACTIVATE)))
end
function c59438930.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c59438930.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return re:GetHandler():IsDestructable() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
end
function c59438930.operation(e,tp,eg,ep,ev,re,r,rp)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
