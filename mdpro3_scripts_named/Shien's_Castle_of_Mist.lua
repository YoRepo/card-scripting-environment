--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Shien's Castle of Mist  (ID: 11102908)
-- Type: Spell / Field
-- Setcode: 0x20
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a "Six Samurai" monster is attacked, the attacking monster loses 500 ATK during damage
-- calculation only.
--[[ __CARD_HEADER_END__ ]]

--紫炎の霞城
function c11102908.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk down
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCondition(c11102908.atkcon)
	e2:SetTarget(c11102908.atktg)
	e2:SetValue(-500)
	c:RegisterEffect(e2)
end
function c11102908.atkcon(e)
	local d=Duel.GetAttackTarget()
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL and d and d:IsSetCard(0x103d)
end
function c11102908.atktg(e,c)
	return c==Duel.GetAttacker()
end
