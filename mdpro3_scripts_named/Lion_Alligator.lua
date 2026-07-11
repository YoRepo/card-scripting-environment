--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Lion Alligator  (ID: 4611269)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Reptile
-- Level: 4
-- ATK 1900 | DEF 200
-- Scope: OCG / TCG
--
-- Effect Text:
-- While you control another Reptile monster, if a Reptile monster you control attacks a Defense
-- Position monster, inflict piercing battle damage.
--[[ __CARD_HEADER_END__ ]]

--ライオ・アリゲーター
function c4611269.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(c4611269.condition)
	e1:SetTarget(c4611269.target)
	c:RegisterEffect(e1)
end
function c4611269.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_REPTILE)
end
function c4611269.condition(e)
	return Duel.IsExistingMatchingCard(c4611269.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
function c4611269.target(e,c)
	return c:IsRace(RACE_REPTILE)
end
