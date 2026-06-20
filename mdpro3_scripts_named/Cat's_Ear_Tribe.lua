--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 猫耳族  (ID: 95841282)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level 1
-- ATK 200 | DEF 100
--
-- Effect Text:
-- 对方回合时，与这张卡战斗的怪兽的原本攻击力在伤害步骤时变成200。
--[[ __CARD_HEADER_END__ ]]

--ネコ耳族
function c95841282.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetTarget(c95841282.atktg)
	e1:SetCondition(c95841282.atkcon)
	e1:SetValue(200)
	c:RegisterEffect(e1)
end
function c95841282.atkcon(e)
	local ph=Duel.GetCurrentPhase()
	return (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) and Duel.GetTurnPlayer()~=e:GetHandlerPlayer()
		and Duel.GetAttackTarget()==e:GetHandler()
end
function c95841282.atktg(e,c)
	return c==e:GetHandler():GetBattleTarget()
end
