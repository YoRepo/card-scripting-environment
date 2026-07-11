--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Ritual Beast Tamer Elder  (ID: 14513016)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Psychic
-- Level: 2
-- ATK 200 | DEF 1000
-- Setcode: 0x10b5
-- Scope: OCG / TCG
--
-- Effect Text:
-- After you Normal Summon this card, you can Normal Summon 1 "Ritual Beast" monster during your Main
-- Phase this turn, in addition to your Normal Summon/Set.
-- (You can only gain this effect once per turn.)
-- You can only Special Summon "Ritual Beast Tamer Elder(s)" once per turn.
--[[ __CARD_HEADER_END__ ]]

--霊獣使いの長老
function c14513016.initial_effect(c)
	c:SetSPSummonOnce(14513016)
	--extra summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c14513016.sumop)
	c:RegisterEffect(e1)
end
function c14513016.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,14513016)~=0 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(14513016,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xb5))
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,14513016,RESET_PHASE+PHASE_END,0,1)
end
