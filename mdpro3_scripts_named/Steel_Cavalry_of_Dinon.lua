--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 迪隆的钢铁骑兵  (ID: 2396042)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Dinosaur
-- Level 4
-- Pendulum Scales: L5 / R5
-- ATK 1600 | DEF 2600
--
-- Effect Text:
-- ←5 【灵摆】 5→
-- 【怪兽效果】
-- ①：这张卡和灵摆怪兽进行战斗的伤害步骤开始时发动。这张卡的攻击力·守备力直到伤害步骤结束时变成一半。
--[[ __CARD_HEADER_END__ ]]

--ディノンの鋼鉄騎兵
function c2396042.initial_effect(c)
	aux.EnablePendulumAttribute(c)
	--atk/def
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2396042,0))
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetCondition(c2396042.adcon)
	e1:SetOperation(c2396042.adop)
	c:RegisterEffect(e1)
end
function c2396042.adcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:IsFaceup() and bc:IsType(TYPE_PENDULUM)
end
function c2396042.adop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e1:SetValue(math.ceil(c:GetDefense()/2))
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_DAMAGE)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_ATTACK_FINAL)
		e2:SetValue(math.ceil(c:GetAttack()/2))
		c:RegisterEffect(e2)
	end
end
