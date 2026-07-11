--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Magical Thorn  (ID: 53119267)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- When your opponent's card(s) in their hand are discarded to the Graveyard, inflict 500 points of
-- damage to their Life Points for each card that was discarded.
--[[ __CARD_HEADER_END__ ]]

--魔力の棘
function c53119267.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetOperation(c53119267.damop)
	c:RegisterEffect(e2)
end
function c53119267.filter(c,tp)
	return c:IsPreviousLocation(LOCATION_HAND) and c:IsControler(1-tp) and c:IsPreviousControler(1-tp)
		and c:IsReason(REASON_DISCARD)
end
function c53119267.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=eg:FilterCount(c53119267.filter,nil,tp)
	Duel.Damage(1-tp,ct*500,REASON_EFFECT)
end
