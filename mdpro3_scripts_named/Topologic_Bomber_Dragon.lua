--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 拓扑逻辑轰炸龙  (ID: 5821478)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Cyberse
-- ATK 3000 | LINK
-- Setcode: 366
--
-- Effect Text:
-- 效果怪兽2只以上
-- ①：这张卡已在怪兽区域存在的状态，这张卡以外的怪兽在连接怪兽所连接区特殊召唤的场合发动。双方的主要怪兽区域的怪兽全部破坏。这个回合，这张卡以外的自己怪兽不能攻击。
-- ②：这张卡向对方怪兽攻击的伤害计算后发动。给与对方那只对方怪兽的原本攻击力数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--トポロジック・ボマー・ドラゴン
function c5821478.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_EFFECT),2)
	c:EnableReviveLimit()
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(5821478,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,EFFECT_COUNT_CODE_CHAIN)
	e1:SetCondition(c5821478.descon)
	e1:SetTarget(c5821478.destg)
	e1:SetOperation(c5821478.desop)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(5821478,1))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLED)
	e2:SetCondition(c5821478.damcon)
	e2:SetTarget(c5821478.damtg)
	e2:SetOperation(c5821478.damop)
	c:RegisterEffect(e2)
end
function c5821478.cfilter(c,zone)
	local seq=c:GetSequence()
	if c:IsLocation(LOCATION_MZONE) then
		if c:IsControler(1) then seq=seq+16 end
	else
		seq=c:GetPreviousSequence()
		if c:IsPreviousControler(1) then seq=seq+16 end
	end
	return bit.extract(zone,seq)~=0
end
function c5821478.descon(e,tp,eg,ep,ev,re,r,rp)
	local zone=Duel.GetLinkedZone(0)+(Duel.GetLinkedZone(1)<<0x10)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c5821478.cfilter,1,nil,zone)
end
function c5821478.desfilter(c)
	return c:GetSequence()<5
end
function c5821478.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c5821478.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c5821478.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c5821478.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c5821478.ftarget)
	e1:SetLabel(e:GetHandler():GetFieldID())
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c5821478.ftarget(e,c)
	return e:GetLabel()~=c:GetFieldID()
end
function c5821478.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()==e:GetHandler() and Duel.GetAttackTarget()
end
function c5821478.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,Duel.GetAttackTarget():GetBaseAttack())
end
function c5821478.damop(e,tp,eg,ep,ev,re,r,rp)
	local bc=Duel.GetAttackTarget()
	if bc and bc:IsRelateToBattle() and bc:IsFaceup() then
		Duel.Damage(1-tp,bc:GetBaseAttack(),REASON_EFFECT)
	end
end
