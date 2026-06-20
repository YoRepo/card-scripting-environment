--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 最高战士  (ID: 94538053)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Warrior
-- Level 4
-- ATK 1800 | DEF 800
-- Setcode: 102
--
-- Effect Text:
-- 这张卡向对方怪兽攻击的场合，伤害步骤内攻击力上升400。这张卡战斗破坏对方怪兽的场合，直到下次的自己的准备阶段时这张卡的等级变成2星，原本的攻击力·守备力成为一半数值。
--[[ __CARD_HEADER_END__ ]]

--マックス・ウォリアー
function c94538053.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c94538053.condtion)
	e1:SetValue(400)
	c:RegisterEffect(e1)
	--addown
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(94538053,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c94538053.atkcon)
	e2:SetOperation(c94538053.atkop)
	c:RegisterEffect(e2)
end
function c94538053.condtion(e)
	local ph=Duel.GetCurrentPhase()
	return (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL)
		and Duel.GetAttacker()==e:GetHandler() and Duel.GetAttackTarget()~=nil
end
function c94538053.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsRelateToBattle() and e:GetHandler():IsFaceup()
end
function c94538053.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToBattle() and c:IsFaceup() then
		local batk=c:GetBaseAttack()
		local bdef=c:GetBaseDefense()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK_FINAL)
		e1:SetValue(math.ceil(batk/2))
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_BASE_DEFENSE_FINAL)
		e2:SetValue(math.ceil(bdef/2))
		c:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_CHANGE_LEVEL)
		e3:SetValue(2)
		c:RegisterEffect(e3)
	end
end
