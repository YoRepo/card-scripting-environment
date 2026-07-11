--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Lector Pendulum, the Dracoverlord  (ID: 7127502)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Dragon
-- Level: 4
-- ATK 1950 | DEF 0
-- Pendulum Scale: L5 / R5
-- Setcode: 0xda, 0xf2
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 5
-- [ Pendulum Effect ]
-- Negate the effects of face-up Pendulum Monsters while your opponent controls them.
-- ----------------------------------------
-- [ Monster Effect ]
-- At the start of the Damage Step, if this card battles a Pendulum Monster: Destroy both that monster
-- and this card.
--[[ __CARD_HEADER_END__ ]]

--竜魔王レクターP
function c7127502.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetTarget(c7127502.distg)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetTarget(c7127502.destg)
	e2:SetOperation(c7127502.desop)
	c:RegisterEffect(e2)
end
function c7127502.distg(e,c)
	return c:IsType(TYPE_PENDULUM)
end
function c7127502.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if chk==0 then return tc and tc:IsFaceup() and tc:IsType(TYPE_PENDULUM) end
	local g=Group.FromCards(c,tc)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,2,0,0)
end
function c7127502.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if c:IsRelateToBattle() and tc:IsRelateToBattle() then
		local g=Group.FromCards(c,tc)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
