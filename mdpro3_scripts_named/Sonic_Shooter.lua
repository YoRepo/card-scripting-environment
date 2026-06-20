--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 音速射手  (ID: 40384720)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level 4
-- ATK 1300 | DEF 600
--
-- Effect Text:
-- 对方的魔法·陷阱卡区域没有卡存在的场合，这张卡可以直接攻击对方玩家。这个时候，给与对方玩家的战斗伤害变成这张卡的原本攻击力的数值。
--[[ __CARD_HEADER_END__ ]]

--ソニック・シューター
function c40384720.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c40384720.dircon)
	c:RegisterEffect(e1)
	--damage reduce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e2:SetCondition(c40384720.rdcon)
	e2:SetValue(c40384720.rdval)
	c:RegisterEffect(e2)
end
function c40384720.dfilter(c)
	return c:GetSequence()<5
end
function c40384720.dircon(e)
	return not Duel.IsExistingMatchingCard(c40384720.dfilter,e:GetHandlerPlayer(),0,LOCATION_SZONE,1,nil)
end
function c40384720.rdcon(e)
	local c=e:GetHandler()
	local tp=e:GetHandlerPlayer()
	return Duel.GetAttackTarget()==nil
		and c:GetEffectCount(EFFECT_DIRECT_ATTACK)<2 and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
end
function c40384720.rdval(e,damp)
	if damp==1-e:GetHandlerPlayer() then
		return e:GetHandler():GetBaseAttack()
	else return -1 end
end
