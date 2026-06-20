--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 一击喷射士  (ID: 6142213)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Machine
-- Level 2
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这张卡攻击的场合，这张卡不会被战斗破坏。那次伤害计算后，给与对方基本分攻击对象怪兽的攻击力一半数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--ワンショット・ロケット
function c6142213.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6142213,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(c6142213.condition)
	e1:SetTarget(c6142213.target)
	e1:SetOperation(c6142213.operation)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetCondition(c6142213.indcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c6142213.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttacker() and Duel.GetAttackTarget()
end
function c6142213.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dam=math.floor(Duel.GetAttackTarget():GetAttack()/2)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,1-tp,dam)
end
function c6142213.operation(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Damage(p,math.floor(Duel.GetAttackTarget():GetAttack()/2),REASON_EFFECT)
end
function c6142213.indcon(e)
	return e:GetHandler()==Duel.GetAttacker()
end
