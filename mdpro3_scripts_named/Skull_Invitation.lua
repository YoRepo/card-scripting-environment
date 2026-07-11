--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Skull Invitation  (ID: 98139712)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Each time a card(s) is sent to the Graveyard, inflict 300 damage to its owner for each card sent.
--[[ __CARD_HEADER_END__ ]]

--死霊の誘い
function c98139712.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c98139712.operation)
	c:RegisterEffect(e2)
end
function c98139712.filter1(c,tp)
	return c:GetOwner()==1-tp
end
function c98139712.filter2(c,tp)
	return c:GetOwner()==tp
end
function c98139712.operation(e,tp,eg,ep,ev,re,r,rp)
	local d1=eg:FilterCount(c98139712.filter1,nil,tp)*300
	local d2=eg:FilterCount(c98139712.filter2,nil,tp)*300
	Duel.Damage(1-tp,d1,REASON_EFFECT,true)
	Duel.Damage(tp,d2,REASON_EFFECT,true)
	Duel.RDComplete()
end
