--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 机皇兵 神智一型  (ID: 39648965)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 4
-- ATK 1800 | DEF 0
-- Setcode: 24595
--
-- Effect Text:
-- ①：这张卡的攻击力上升这张卡以外的场上的「机皇」怪兽数量×100。
-- ②：1回合1次，这张卡以外的自己的「机皇」怪兽向守备表示怪兽攻击宣言时才能发动。那次战斗用那只自己怪兽向守备表示怪兽攻击的场合，给与对方为攻击力超过那个守备力的数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--機皇兵ワイゼル・アイン
function c39648965.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c39648965.val)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(39648965,0))
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c39648965.piercecon)
	e2:SetTarget(c39648965.piercetg)
	e2:SetOperation(c39648965.pierceop)
	c:RegisterEffect(e2)
end
function c39648965.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x13)
end
function c39648965.val(e,c)
	return Duel.GetMatchingGroupCount(c39648965.atkfilter,0,LOCATION_MZONE,LOCATION_MZONE,c)*100
end
function c39648965.piercecon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d and a:IsControler(tp) and a~=e:GetHandler() and d:IsDefensePos() and a:IsSetCard(0x13)
end
function c39648965.piercetg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.GetAttacker():CreateEffectRelation(e)
end
function c39648965.pierceop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if a:IsRelateToEffect(e) and a:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_PIERCE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		a:RegisterEffect(e1)
	end
end
