--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Terra Firma Gravity  (ID: 26509612)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- During your opponent's Battle Phase, if you control "Elemental HERO Terra Firma": This turn, all
-- Level 4 or lower monsters your opponent controls that can attack a face-up "Elemental HERO Terra
-- Firma" you control must attack it, and cannot otherwise attack.
--[[ __CARD_HEADER_END__ ]]

--アース・グラビティ
function c26509612.initial_effect(c)
	aux.AddSetNameMonsterList(c,0x3008)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START)
	e1:SetCondition(c26509612.condition)
	e1:SetTarget(c26509612.target)
	e1:SetOperation(c26509612.activate)
	c:RegisterEffect(e1)
end
function c26509612.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE)
end
function c26509612.filter1(c)
	return c:IsFaceup() and c:IsCode(74711057)
end
function c26509612.filter2(c)
	return c:IsFaceup() and c:IsLevelBelow(4)
end
function c26509612.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c26509612.filter1,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c26509612.filter2,tp,0,LOCATION_MZONE,1,nil) end
end
function c26509612.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_MUST_ATTACK)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetTarget(c26509612.attg)
	e1:SetReset(RESET_PHASE+PHASE_BATTLE)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_MUST_ATTACK_MONSTER)
	e2:SetValue(c26509612.atklimit)
	Duel.RegisterEffect(e2,tp)
end
function c26509612.attg(e,c)
	return c:IsLevelBelow(4)
end
function c26509612.atklimit(e,c)
	return c:IsCode(74711057)
end
