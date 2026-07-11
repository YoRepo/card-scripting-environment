--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Bubble Barrier  (ID: 79777187)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- The first time each "Performapal" and "Performage" monster you control would be destroyed by battle
-- or card effect each turn, it is not destroyed.
-- You take no battle damage from attacks involving "Performapal" and "Performage" monsters you
-- control.
--[[ __CARD_HEADER_END__ ]]

--バリア・バブル
function c79777187.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--avoid battle damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c79777187.target)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c79777187.target)
	e3:SetValue(c79777187.indct)
	c:RegisterEffect(e3)
end
function c79777187.target(e,c)
	return c:IsSetCard(0xc6,0x9f)
end
function c79777187.indct(e,re,r,rp)
	if bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0 then
		return 1
	else return 0 end
end
