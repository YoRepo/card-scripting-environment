--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Cave Dragon  (ID: 93220472)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Dragon
-- Level: 4
-- ATK 2000 | DEF 100
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Normal Summoned while you control a monster.
-- This card cannot declare an attack unless you control another Dragon-Type monster.
--[[ __CARD_HEADER_END__ ]]

--グランド・ドラゴン
function c93220472.initial_effect(c)
	--sumlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetCondition(c93220472.sumcon)
	c:RegisterEffect(e1)
	--atklimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetCondition(c93220472.atkcon)
	c:RegisterEffect(e2)
end
function c93220472.sumcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_MZONE,0)>0
end
function c93220472.afilter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON)
end
function c93220472.atkcon(e)
	return not Duel.IsExistingMatchingCard(c93220472.afilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
