--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Light-Imprisoning Mirror  (ID: 53341729)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Negate all LIGHT monster effects activated on the field or in the GY.
--[[ __CARD_HEADER_END__ ]]

--閃光を吸い込むマジック・ミラー
function c53341729.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetOperation(c53341729.disop)
	c:RegisterEffect(e2)
end
function c53341729.disop(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if re:IsActiveType(TYPE_MONSTER) and (loc==LOCATION_MZONE or loc==LOCATION_GRAVE)
		and re:GetHandler():IsAttribute(ATTRIBUTE_LIGHT) then
		Duel.NegateEffect(ev)
	end
end
