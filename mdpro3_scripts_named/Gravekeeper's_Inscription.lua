--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Gravekeeper's Inscription  (ID: 59494222)
-- Type: Spell
-- Setcode: 0x2e
-- Scope: OCG / TCG
--
-- Effect Text:
-- At the start of your Main Phase 1: Apply 1 of the following effects until the end of your opponent's
-- turn.
-- ● Neither player can activate card effects in the GY.
-- ● Neither player can banish cards from the GY.
-- ● Neither player can Special Summon monsters from the GYs.
--[[ __CARD_HEADER_END__ ]]

--墓守の刻印
function c59494222.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c59494222.condition)
	e1:SetOperation(c59494222.activate)
	c:RegisterEffect(e1)
end
function c59494222.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 and not Duel.CheckPhaseActivity()
end
function c59494222.activate(e,tp,eg,ep,ev,re,r,rp)
	local op=Duel.SelectOption(tp,aux.Stringid(59494222,0),aux.Stringid(59494222,1),aux.Stringid(59494222,2))
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetTargetRange(1,1)
	if op==0 then
		e1:SetDescription(aux.Stringid(59494222,0))
		e1:SetCode(EFFECT_CANNOT_ACTIVATE)
		e1:SetValue(c59494222.actlimit)
	elseif op==1 then
		e1:SetDescription(aux.Stringid(59494222,1))
		e1:SetCode(EFFECT_CANNOT_REMOVE)
		e1:SetTarget(c59494222.rmlimit)
	else
		e1:SetDescription(aux.Stringid(59494222,2))
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetTarget(c59494222.splimit)
	end
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	Duel.RegisterEffect(e1,tp)
end
function c59494222.actlimit(e,re,tp)
	return re:GetActivateLocation()==LOCATION_GRAVE
end
function c59494222.rmlimit(e,c)
	return c:IsLocation(LOCATION_GRAVE)
end
function c59494222.splimit(e,c)
	return c:IsLocation(LOCATION_GRAVE) and c:IsType(TYPE_MONSTER)
end
