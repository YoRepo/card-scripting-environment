--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Queen of Thorns  (ID: 45500495)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Plant
-- Level: 6
-- ATK 2200 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Tuner + 1+ non-Tuner Plant monsters
-- Each player must pay 1000 LP for each monster Normal or Special Summoned from their hand, except
-- Plant monsters.
--[[ __CARD_HEADER_END__ ]]

--ヘル・ブランブル
function c45500495.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsRace,RACE_PLANT),1)
	c:EnableReviveLimit()
	--cost
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SUMMON_COST)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_HAND,LOCATION_HAND)
	e1:SetTarget(c45500495.sumtg)
	e1:SetCost(c45500495.ccost)
	e1:SetOperation(c45500495.acop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SPSUMMON_COST)
	c:RegisterEffect(e2)
end
function c45500495.sumtg(e,c)
	return c:GetRace()~=RACE_PLANT
end
function c45500495.ccost(e,c,tp)
	return Duel.CheckLPCost(tp,1000)
end
function c45500495.acop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PayLPCost(tp,1000)
end
