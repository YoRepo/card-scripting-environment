--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 发条骑士  (ID: 80538728)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 4
-- ATK 1800 | DEF 1200
-- Setcode: 88
--
-- Effect Text:
-- 自己场上表侧表示存在的名字带有「发条」的怪兽被选择作为攻击对象时，可以把那只怪兽的攻击无效。这个效果只在这张卡在场上表侧表示存在能使用1次。
--[[ __CARD_HEADER_END__ ]]

--ゼンマイナイト
function c80538728.initial_effect(c)
	--negate attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80538728,0))
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c80538728.condition)
	e1:SetOperation(c80538728.operation)
	c:RegisterEffect(e1)
end
function c80538728.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsControler(tp) and d:IsFaceup() and d:IsSetCard(0x58)
end
function c80538728.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
