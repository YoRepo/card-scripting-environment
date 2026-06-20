--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 星光体障壁  (ID: 37053871)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方怪兽攻击自己场上怪兽的场合，可以把那个攻击变成对自己基本分的直接攻击。
--[[ __CARD_HEADER_END__ ]]

--アストラルバリア
function c37053871.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--target change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(37053871,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c37053871.atkcon)
	e2:SetTarget(c37053871.atktg)
	e2:SetOperation(c37053871.atkop)
	c:RegisterEffect(e2)
end
function c37053871.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	return a:IsControler(1-tp) and at and at:IsControler(tp)
end
function c37053871.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.GetAttacker():IsHasEffect(EFFECT_CANNOT_DIRECT_ATTACK) end
end
function c37053871.atkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeAttackTarget(nil)
end
