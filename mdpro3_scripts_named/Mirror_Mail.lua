--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 神圣之铠 -反射镜甲-  (ID: 67232306)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上表侧表示存在的怪兽被选择作为攻击对象时才能发动。攻击对象怪兽的攻击力变成和攻击怪兽的攻击力相同。
--[[ __CARD_HEADER_END__ ]]

--聖なる鎧 －ミラーメール－
function c67232306.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetTarget(c67232306.target)
	e1:SetOperation(c67232306.operation)
	c:RegisterEffect(e1)
end
function c67232306.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local at=eg:GetFirst()
	local a=Duel.GetAttacker()
	if chk==0 then return at:IsControler(tp) and at:IsOnField() and at:IsFaceup() and a:IsOnField() end
	at:CreateEffectRelation(e)
	a:CreateEffectRelation(e)
end
function c67232306.operation(e,tp,eg,ep,ev,re,r,rp)
	local at=eg:GetFirst()
	local a=Duel.GetAttacker()
	if not a:IsRelateToEffect(e) or not at:IsRelateToEffect(e) or a:IsFacedown() or at:IsFacedown() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(a:GetAttack())
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	at:RegisterEffect(e1)
end
