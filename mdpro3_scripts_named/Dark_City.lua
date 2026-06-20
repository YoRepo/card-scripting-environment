--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 暗黑都市  (ID: 53527835)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：「命运英雄」怪兽向持有比那个攻击力高的攻击力的怪兽攻击的场合，攻击怪兽的攻击力只在伤害计算时上升1000。
--[[ __CARD_HEADER_END__ ]]

--ダーク・シティ
function c53527835.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCondition(c53527835.atkcon)
	e2:SetTarget(c53527835.atktg)
	e2:SetValue(c53527835.atkval)
	c:RegisterEffect(e2)
end
function c53527835.atkcon(e)
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL and Duel.GetAttackTarget()
end
function c53527835.atktg(e,c)
	return c==Duel.GetAttacker() and c:IsSetCard(0xc008)
end
function c53527835.atkval(e,c)
	local d=Duel.GetAttackTarget()
	if c:GetAttack()<d:GetAttack() then
		return 1000
	else return 0 end
end
