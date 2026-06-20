--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 亚马逊的斗志  (ID: 36100154)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 4
--
-- Effect Text:
-- 名字带有「亚马逊」的怪兽向持有比那个攻击力高的攻击力的怪兽攻击的场合，只在伤害计算时攻击怪兽的攻击力上升1000。
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
