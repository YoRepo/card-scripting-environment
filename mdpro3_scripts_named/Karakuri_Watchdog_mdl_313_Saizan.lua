--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 机巧守卫 三一三  (ID: 70271583)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Machine
-- Level 4
-- ATK 600 | DEF 1800
-- Setcode: 17
--
-- Effect Text:
-- 这张卡可以攻击的场合必须作出攻击。场上表侧表示存在的这张卡被选择作为攻击对象时，这张卡的表示形式变更。这张卡的战斗让自己受到战斗伤害时，自己场上表侧表示存在的名字带有「机巧」的全部怪兽的攻击力·守备力
-- 直到结束阶段时上升800。此外，这张卡只要在场上表侧攻击表示存在不会被战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--カラクリ守衛 参壱参
function c70271583.initial_effect(c)
	--must attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MUST_ATTACK)
	c:RegisterEffect(e1)
	--pos change
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(70271583,0))
	e3:SetCategory(CATEGORY_POSITION)
	e3:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetOperation(c70271583.posop)
	c:RegisterEffect(e3)
	--atkup
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(70271583,1))
	e4:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e4:SetCode(EVENT_BATTLE_DAMAGE)
	e4:SetCondition(c70271583.atkcon)
	e4:SetOperation(c70271583.atkop)
	c:RegisterEffect(e4)
	--indes
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e5:SetCondition(c70271583.indcon)
	e5:SetValue(1)
	c:RegisterEffect(e5)
end
function c70271583.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
	end
end
function c70271583.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and (e:GetHandler()==Duel.GetAttacker() or e:GetHandler()==Duel.GetAttackTarget())
end
function c70271583.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x11)
end
function c70271583.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c70271583.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(800)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end
function c70271583.indcon(e)
	return e:GetHandler():IsPosition(POS_FACEUP_ATTACK)
end
