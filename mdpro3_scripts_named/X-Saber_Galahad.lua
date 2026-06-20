--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: X-剑士 加拉哈德  (ID: 50604950)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1800 | DEF 800
-- Setcode: 4109
--
-- Effect Text:
-- 这张卡向对方怪兽攻击的场合，伤害步骤内攻击力上升300。这张卡被对方怪兽攻击的场合，伤害步骤内攻击力下降500。这张卡被选择作为攻击对象时，可以把自己场上存在的这张卡以外的1只名字带有「剑士」的怪兽解
-- 放，那次攻击无效。
--[[ __CARD_HEADER_END__ ]]

--X－セイバー ガラハド
function c50604950.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c50604950.atkval)
	c:RegisterEffect(e1)
	--negate attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(50604950,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetCost(c50604950.cost)
	e2:SetOperation(c50604950.operation)
	c:RegisterEffect(e2)
end
function c50604950.atkval(e,c)
	local ph=Duel.GetCurrentPhase()
	if ph~=PHASE_DAMAGE and ph~=PHASE_DAMAGE_CAL then return 0 end
	if c==Duel.GetAttacker() and Duel.GetAttackTarget() then return 300 end
	if c==Duel.GetAttackTarget() then return -500 end
	return 0
end
function c50604950.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,e:GetHandler(),0xd) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,e:GetHandler(),0xd)
	Duel.Release(g,REASON_COST)
end
function c50604950.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
