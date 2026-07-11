--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Reverse Trap  (ID: 77622396)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Until the End Phase, all effects that add or subtract ATK or DEF are reversed.
-- (Additions now subtract, and subtractions now add, instead. Multiplications and divisions, including
-- halving/doubling, are not affected.)
--[[ __CARD_HEADER_END__ ]]

--あまのじゃくの呪い
function c77622396.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c77622396.activate)
	c:RegisterEffect(e1)
end
function c77622396.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_REVERSE_UPDATE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	Duel.RegisterEffect(e1,tp)
end
