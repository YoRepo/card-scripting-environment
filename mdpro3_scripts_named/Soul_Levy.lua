--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Soul Levy  (ID: 87844926)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can only control 1 "Soul Levy".
-- Each time your opponent Special Summons a monster(s), send the top 3 cards of your opponent's Deck
-- to the GY.
--[[ __CARD_HEADER_END__ ]]

--ソウル・レヴィ
function c87844926.initial_effect(c)
	c:SetUniqueOnField(1,0,87844926)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--deckdes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c87844926.ddcon)
	e2:SetOperation(c87844926.ddop)
	c:RegisterEffect(e2)
end
function c87844926.cfilter(c,tp)
	return c:IsSummonPlayer(tp)
end
function c87844926.ddcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c87844926.cfilter,1,nil,1-tp)
end
function c87844926.ddop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(1-tp,3,REASON_EFFECT)
end
