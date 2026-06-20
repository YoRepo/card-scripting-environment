--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 紫炎的霞城  (ID: 11102908)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 32
--
-- Effect Text:
-- 名字带有「六武众」的怪兽被攻击时，攻击怪兽的攻击力下降500。
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
