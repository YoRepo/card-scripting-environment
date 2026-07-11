--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Temple of the Sun  (ID: 91468551)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Face-up monsters you control that were Special Summoned from the Graveyard gain 300 ATK.
--[[ __CARD_HEADER_END__ ]]

--太陽の祭壇
function c91468551.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c91468551.atktg)
	e2:SetValue(300)
	c:RegisterEffect(e2)
end
function c91468551.atktg(e,c)
	return c:IsSummonType(SUMMON_TYPE_SPECIAL) and c:IsSummonLocation(LOCATION_GRAVE)
end
