--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Blackwing Armed Wing  (ID: 76913983)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Winged Beast
-- Level: 6
-- ATK 2300 | DEF 1000
-- Setcode: 0x33
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 "Blackwing" Tuner + 1+ non-Tuner monsters
-- If this card attacks a Defense Position monster, it gains 500 ATK during the Damage Step only, also
-- inflict piercing battle damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--BF－アームズ・ウィング
function c76913983.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x33),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c76913983.atkcon)
	e1:SetValue(500)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
end
function c76913983.atkcon(e)
	local ph=Duel.GetCurrentPhase()
	if ph~=PHASE_DAMAGE and ph~=PHASE_DAMAGE_CAL then return false end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return e:GetHandler()==a and d and d:IsDefensePos()
end
