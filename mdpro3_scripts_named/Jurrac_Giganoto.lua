--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Jurrac Giganoto  (ID: 80032567)
-- Type: Monster / Effect / Synchro
-- Attribute: FIRE
-- Race: Dinosaur
-- Level: 7
-- ATK 2100 | DEF 1800
-- Setcode: 0x22
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Tuner + 1+ non-Tuner Dinosaur monsters
-- "Jurrac" monsters you control gain 200 ATK for each "Jurrac" monster in your GY.
--[[ __CARD_HEADER_END__ ]]

--ジュラック・ギガノト
function c80032567.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsRace,RACE_DINOSAUR),1)
	c:EnableReviveLimit()
	--Atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x22))
	e1:SetValue(c80032567.val)
	c:RegisterEffect(e1)
end
function c80032567.filter(c)
	return c:IsSetCard(0x22) and c:IsType(TYPE_MONSTER)
end
function c80032567.val(e,c)
	return Duel.GetMatchingGroupCount(c80032567.filter,e:GetHandlerPlayer(),LOCATION_GRAVE,0,nil)*200
end
