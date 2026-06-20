--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 潜艇机人  (ID: 99861526)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Machine
-- Level 4
-- ATK 800 | DEF 1800
-- Setcode: 22
--
-- Effect Text:
-- 这张卡可以直接攻击对方玩家。这个时候，给与对方玩家的战斗伤害变成这张卡的原本攻击力的数值。此外，伤害步骤结束时这张卡的表示形式可以变成守备表示。
--[[ __CARD_HEADER_END__ ]]

--サブマリンロイド
function c99861526.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
	--damage reduce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e2:SetCondition(c99861526.rdcon)
	e2:SetValue(c99861526.rval)
	c:RegisterEffect(e2)
	--pos
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(99861526,0))
	e3:SetCategory(CATEGORY_POSITION)
	e3:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_DAMAGE_STEP_END)
	e3:SetCondition(c99861526.poscon)
	e3:SetOperation(c99861526.posop)
	c:RegisterEffect(e3)
end
function c99861526.rdcon(e)
	local c=e:GetHandler()
	local tp=e:GetHandlerPlayer()
	return Duel.GetAttackTarget()==nil
		and c:GetEffectCount(EFFECT_DIRECT_ATTACK)<2 and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
end
function c99861526.rval(e,damp)
	if damp==1-e:GetHandlerPlayer() then
		return e:GetHandler():GetBaseAttack()
	else return -1 end
end
function c99861526.poscon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsRelateToBattle() and c:IsAttackPos()
end
function c99861526.posop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.ChangePosition(e:GetHandler(),POS_FACEUP_DEFENSE)
	end
end
