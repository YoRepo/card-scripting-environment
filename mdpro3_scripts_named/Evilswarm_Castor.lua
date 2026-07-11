--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Evilswarm Castor  (ID: 79785958)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level: 4
-- ATK 1750 | DEF 550
-- Setcode: 0xa
-- Scope: OCG / TCG
--
-- Effect Text:
-- During the turn this card was Normal Summoned, you can Normal Summon 1 "lswarm" monster in addition
-- to your Normal Summon/Set.
-- (You can only gain this effect once per turn.)
--[[ __CARD_HEADER_END__ ]]

--ヴェルズ・カストル
function c79785958.initial_effect(c)
	--extra summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c79785958.sumop)
	c:RegisterEffect(e1)
end
function c79785958.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,79785958)~=0 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(79785958,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xa))
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,79785958,RESET_PHASE+PHASE_END,0,1)
end
