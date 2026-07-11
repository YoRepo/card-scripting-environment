--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Amazoness Fighting Spirit  (ID: 36100154)
-- Type: Spell / Continuous
-- Setcode: 0x4
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your "Amazoness" monster attacks a monster with higher ATK, the attacking monster gains 1000 ATK
-- during damage calculation only.
--[[ __CARD_HEADER_END__ ]]

--アマゾネスの闘志
function c36100154.initial_effect(c)
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
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCondition(c36100154.atkcon)
	e2:SetTarget(c36100154.atktg)
	e2:SetValue(c36100154.atkval)
	c:RegisterEffect(e2)
end
function c36100154.atkcon(e)
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL and Duel.GetAttackTarget()
		and Duel.GetAttacker():IsControler(e:GetHandlerPlayer())
end
function c36100154.atktg(e,c)
	return c==Duel.GetAttacker() and c:IsSetCard(0x4)
end
function c36100154.atkval(e,c)
	local d=Duel.GetAttackTarget()
	if c:GetAttack()<d:GetAttack() then
		return 1000
	else return 0 end
end
