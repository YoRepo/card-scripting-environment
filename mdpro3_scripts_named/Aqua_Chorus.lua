--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Aqua Chorus  (ID: 95132338)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- If there are monsters with the same name on the field, those monsters gain 500 ATK/DEF.
--[[ __CARD_HEADER_END__ ]]

--アクアの合唱
function c95132338.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(aux.dscon)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c95132338.target)
	e2:SetValue(500)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
end
function c95132338.cfilter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c95132338.target(e,c)
	return Duel.IsExistingMatchingCard(c95132338.cfilter,0,LOCATION_MZONE,LOCATION_MZONE,1,c,c:GetCode())
end
