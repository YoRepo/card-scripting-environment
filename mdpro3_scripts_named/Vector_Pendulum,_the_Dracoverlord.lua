--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Vector Pendulum, the Dracoverlord  (ID: 69512157)
-- Type: Monster / Normal / Pendulum
-- Attribute: DARK
-- Race: Dragon
-- Level: 4
-- ATK 1850 | DEF 0
-- Pendulum Scale: L3 / R3
-- Setcode: 0xda, 0xf2
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 3
-- [ Pendulum Effect ]
-- Negate all card effects in your opponent's Pendulum Zones.
-- ----------------------------------------
-- [ Monster Effect ]
-- This Overlord overran an entire world with his army of Dracofiends, using his Dragon Alchemy to
-- convert all life into his terrible minions. The source of this power is unidentified, and probably
-- extra-dimensional.
--[[ __CARD_HEADER_END__ ]]

--竜魔王ベクターP
function c69512157.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(0,LOCATION_PZONE)
	c:RegisterEffect(e2)
	--disable effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAIN_SOLVING)
	e3:SetRange(LOCATION_PZONE)
	e3:SetOperation(c69512157.disop)
	c:RegisterEffect(e3)
end
function c69512157.disop(e,tp,eg,ep,ev,re,r,rp)
	local p,loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_CONTROLER,CHAININFO_TRIGGERING_LOCATION)
	if re:GetActiveType()==TYPE_PENDULUM+TYPE_SPELL and p~=tp and bit.band(loc,LOCATION_PZONE)~=0 then
		Duel.NegateEffect(ev)
	end
end
