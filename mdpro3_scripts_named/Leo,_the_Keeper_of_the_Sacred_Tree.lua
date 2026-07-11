--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Leo, the Keeper of the Sacred Tree  (ID: 8561192)
-- Type: Monster / Effect / Synchro
-- Attribute: EARTH
-- Race: Beast
-- Level: 10
-- ATK 3100 | DEF 1900
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Tuner + 1+ non-Tuner monsters
-- Your opponent cannot target this card with card effects, except during your Main Phase 2.
--[[ __CARD_HEADER_END__ ]]

--神樹の守護獣－牙王
function c8561192.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetCondition(c8561192.tgcon)
	e1:SetValue(aux.tgoval)
	c:RegisterEffect(e1)
end
function c8561192.tgcon(e)
	return Duel.GetTurnPlayer()~=e:GetHandlerPlayer() or Duel.GetCurrentPhase()~=PHASE_MAIN2
end
