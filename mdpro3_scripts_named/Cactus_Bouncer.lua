--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Cactus Bouncer  (ID: 31615285)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level: 4
-- ATK 1800 | DEF 300
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Special Summoned.
-- While another Plant monster is on the field, neither player can Special Summon monsters.
--[[ __CARD_HEADER_END__ ]]

--サボウ・クローザー
function c31615285.initial_effect(c)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--disable spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,1)
	e2:SetCondition(c31615285.dscon)
	c:RegisterEffect(e2)
end
function c31615285.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_PLANT)
end
function c31615285.dscon(e)
	return Duel.IsExistingMatchingCard(c31615285.filter,0,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end
