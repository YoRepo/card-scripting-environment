--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Armored Glass  (ID: 36868108)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can activate this card when a monster is equipped with an Equip Card.
-- Negate the effects of all Equip Cards on the field during the turn this card is activated.
--[[ __CARD_HEADER_END__ ]]

--ガラスの鎧
function c36868108.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_EQUIP)
	e1:SetOperation(c36868108.activate)
	c:RegisterEffect(e1)
end
function c36868108.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e1:SetTarget(c36868108.distarget)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c36868108.distarget(e,c)
	return c:IsType(TYPE_EQUIP)
end
