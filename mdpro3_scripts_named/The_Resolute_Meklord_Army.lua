--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: The Resolute Meklord Army  (ID: 59371387)
-- Type: Spell / Continuous
-- Setcode: 0x6013
-- Scope: OCG / TCG
--
-- Effect Text:
-- All Attack Position "Meklord Army" monsters you control cannot be destroyed by battle, also their
-- effects are negated.
--[[ __CARD_HEADER_END__ ]]

--鉄壁の機皇兵
function c59371387.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c59371387.target)
	e2:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c59371387.target)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c59371387.target(e,c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsSetCard(0x6013)
end
