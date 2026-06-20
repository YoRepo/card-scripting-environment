--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 元素恶魔  (ID: 23118924)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 4
-- ATK 1500 | DEF 1200
--
-- Effect Text:
-- 这只怪兽在场上有特定的属性的怪兽存在的场合，得到以下的效果。
-- ●地属性：这张卡战斗破坏的效果怪兽的效果无效化。
-- ●风属性：这张卡战斗破坏对方怪兽的场合，只有1次可以再度攻击。
--[[ __CARD_HEADER_END__ ]]

--エレメント・デビル
function c23118924.initial_effect(c)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(c23118924.discon)
	e1:SetOperation(c23118924.disop)
	c:RegisterEffect(e1)
	--chain attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(23118924,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetCondition(c23118924.atcon)
	e2:SetOperation(c23118924.atop)
	c:RegisterEffect(e2)
end
function c23118924.filter(c,att)
	return c:IsFaceup() and c:IsAttribute(att)
end
function c23118924.discon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:IsStatus(STATUS_BATTLE_DESTROYED) and not c:IsStatus(STATUS_BATTLE_DESTROYED)
		and Duel.IsExistingMatchingCard(c23118924.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,ATTRIBUTE_EARTH)
end
function c23118924.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetReset(RESET_EVENT+0x17a0000)
	bc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DISABLE_EFFECT)
	e2:SetReset(RESET_EVENT+0x17a0000)
	bc:RegisterEffect(e2)
end
function c23118924.atcon(e,tp,eg,ep,ev,re,r,rp)
	return aux.bdocon(e,tp,eg,ep,ev,re,r,rp) and e:GetHandler():IsChainAttackable()
		and Duel.IsExistingMatchingCard(c23118924.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,ATTRIBUTE_WIND)
end
function c23118924.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end
