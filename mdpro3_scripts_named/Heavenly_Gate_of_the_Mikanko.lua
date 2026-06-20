--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 天御巫之阖  (ID: 17255673)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 397
--
-- Effect Text:
-- ①：只要有装备卡装备的怪兽在自己场上存在，可以攻击的对方怪兽必须向有装备卡装备的怪兽作出攻击。
-- ②：自己的「御巫」怪兽进行战斗的场合，对方直到伤害步骤结束时魔法·陷阱·怪兽的效果不能发动。
-- ③：自己的「御巫」怪兽进行攻击的伤害步骤结束时，把自己场上1张装备卡送去墓地才能发动。那只怪兽向对方怪兽可以继续攻击。
--[[ __CARD_HEADER_END__ ]]

--天御巫の闔
function c17255673.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--must attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_MUST_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCondition(c17255673.atkcon)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_MUST_ATTACK_MONSTER)
	e3:SetValue(c17255673.atklimit)
	c:RegisterEffect(e3)
	--act limit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_ACTIVATE)
	e4:SetRange(LOCATION_FZONE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetTargetRange(0,1)
	e4:SetCondition(c17255673.actcon)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	--extra attack
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetRange(LOCATION_FZONE)
	e5:SetCode(EVENT_DAMAGE_STEP_END)
	e5:SetCondition(c17255673.excon)
	e5:SetCost(c17255673.excost)
	e5:SetOperation(c17255673.exop)
	c:RegisterEffect(e5)
end
function c17255673.atkfilter(c)
	return c:GetEquipCount()>0
end
function c17255673.atkcon(e)
	return Duel.IsExistingMatchingCard(c17255673.atkfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c17255673.atklimit(e,c)
	return c:GetEquipCount()>0
end
function c17255673.actcon(e)
	local a=Duel.GetBattleMonster(e:GetHandlerPlayer())
	return a and a:IsFaceup() and a:IsSetCard(0x18d)
end
function c17255673.excon(e,tp,eg,ep,ev,re,r,rp)
	local ec=Duel.GetAttacker()
	e:SetLabelObject(ec)
	return ec:IsControler(tp) and ec:IsSetCard(0x18d) and ec:IsChainAttackable(0,true)
end
function c17255673.exfilter(c)
	return c:IsType(TYPE_EQUIP) and c:IsAbleToGraveAsCost()
end
function c17255673.excost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c17255673.exfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c17255673.exfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c17255673.exop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=e:GetLabelObject()
	if not ec or not ec:IsRelateToBattle() then return end
	Duel.ChainAttack()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE)
	ec:RegisterEffect(e1)
end
