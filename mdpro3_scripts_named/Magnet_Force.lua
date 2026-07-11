--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Magnet Force  (ID: 17841166)
-- Type: Trap
-- Setcode: 0x1d9
-- Scope: OCG / TCG
--
-- Effect Text:
-- This turn, all monsters on the field whose original Types are Machine or Rock, are unaffected by
-- your opponent's monster effects (except their own).
--[[ __CARD_HEADER_END__ ]]

--マグネット・フォース
function c17841166.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c17841166.activate)
	c:RegisterEffect(e1)
end
function c17841166.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c17841166.etarget)
	e1:SetValue(c17841166.efilter)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c17841166.etarget(e,c)
	return bit.band(c:GetOriginalRace(),RACE_MACHINE+RACE_ROCK)~=0
end
function c17841166.efilter(e,te,c)
	return te:IsActiveType(TYPE_MONSTER) and (te:GetOwner()~=c or te:IsActivated() and not c:IsRelateToEffect(te))
		and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
