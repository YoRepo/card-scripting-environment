--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: World Suppression  (ID: 12253117)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can activate this card when a Field Spell Card is activated.
-- Negate the Field Spell Card during the turn this card is activated.
--[[ __CARD_HEADER_END__ ]]

--世界の平定
function c12253117.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c12253117.condition)
	e1:SetOperation(c12253117.activate)
	c:RegisterEffect(e1)
end
function c12253117.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_FIELD)
end
function c12253117.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e1:SetTarget(c12253117.distarget)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c12253117.distarget(e,c)
	return c:IsType(TYPE_FIELD)
end
