--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 电气红松鼠  (ID: 23274061)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level 3
-- ATK 700 | DEF 100
-- Setcode: 14
--
-- Effect Text:
-- 这张卡在同1次的战斗阶段中可以作2次攻击。和这张卡进行战斗的效果怪兽的效果在伤害计算后无效化。
--[[ __CARD_HEADER_END__ ]]

--エレキタリス
function c23274061.initial_effect(c)
	--Extra attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--Disable
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(23274061,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLED)
	e2:SetCondition(c23274061.condition)
	e2:SetOperation(c23274061.operation)
	c:RegisterEffect(e2)
end
function c23274061.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local a=Duel.GetAttacker()
	if a==c then a=Duel.GetAttackTarget() end
	e:SetLabelObject(a)
	return a and a:IsType(TYPE_EFFECT) and a:IsRelateToBattle()
end
function c23274061.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsFacedown() or not tc:IsRelateToBattle() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetReset(RESET_EVENT+0x57a0000)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DISABLE_EFFECT)
	e2:SetReset(RESET_EVENT+0x57a0000)
	tc:RegisterEffect(e2)
end
