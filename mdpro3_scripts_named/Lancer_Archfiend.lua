--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 枪兵恶魔  (ID: 79418153)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 4
-- ATK 1600 | DEF 1400
-- Setcode: 69
--
-- Effect Text:
-- 对方场上守备表示存在的怪兽为攻击对象的自己怪兽的攻击宣言时才能发动。那只怪兽向守备表示怪兽攻击的场合，若攻击力超过那个守备力，给与对方基本分那个数值的战斗伤害。这个效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--ランサー・デーモン
function c79418153.initial_effect(c)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(79418153,0))
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c79418153.piercecon)
	e1:SetTarget(c79418153.piercetg)
	e1:SetOperation(c79418153.pierceop)
	c:RegisterEffect(e1)
end
function c79418153.piercecon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d and a:IsControler(tp) and d:IsDefensePos()
end
function c79418153.piercetg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.GetAttacker():CreateEffectRelation(e)
end
function c79418153.pierceop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if a:IsRelateToEffect(e) and a:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_PIERCE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		a:RegisterEffect(e1)
	end
end
