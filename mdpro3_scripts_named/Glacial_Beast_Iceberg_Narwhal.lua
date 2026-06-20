--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 极冰兽 冰山一角鲸  (ID: 6568731)
-- Type: Monster / Effect / Synchro
-- Attribute: WATER
-- Race: Aqua
-- Level 7
-- ATK 2700 | DEF 1600
--
-- Effect Text:
-- 调整＋调整以外的水属性怪兽1只以上
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：每次自己场上的其他怪兽被对方怪兽的攻击或者对方的效果破坏发动。给与对方600伤害。
-- ②：自己场上有其他怪兽存在，自己·对方的战斗阶段对方把魔法·陷阱·怪兽的效果发动时才能发动。那个效果无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--極氷獣アイスバーグ・ナーワル
function c6568731.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsAttribute,ATTRIBUTE_WATER),1)
	c:EnableReviveLimit()
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6568731,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c6568731.condition)
	e1:SetTarget(c6568731.target)
	e1:SetOperation(c6568731.operation)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(6568731,1))
	e2:SetCategory(CATEGORY_DISABLE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,6568731)
	e2:SetCondition(c6568731.discon)
	e2:SetTarget(c6568731.distg)
	e2:SetOperation(c6568731.disop)
	c:RegisterEffect(e2)
end
function c6568731.filter(c,tp,rp)
	return c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
		and ((c:IsReason(REASON_EFFECT) and rp==1-tp) or (c:IsReason(REASON_BATTLE) and Duel.GetAttacker():IsControler(1-tp)))
end
function c6568731.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c6568731.filter,1,nil,tp,rp)
end
function c6568731.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(600)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,1-tp,600)
end
function c6568731.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c6568731.discon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ph=Duel.GetCurrentPhase()
	if not (ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE) then return false end
	return not c:IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainDisablable(ev) and ep==1-tp
		and Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,0,1,c)
end
function c6568731.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c6568731.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
