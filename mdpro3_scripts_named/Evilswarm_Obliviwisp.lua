--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 入魔鬼火  (ID: 5284653)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Pyro
-- Level 4
-- ATK 450 | DEF 2050
-- Setcode: 10
--
-- Effect Text:
-- 和这张卡进行战斗的效果怪兽的效果在伤害计算后无效化。
--[[ __CARD_HEADER_END__ ]]

--ヴェルズ・オ・ウィスプ
function c5284653.initial_effect(c)
	--Disable
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(5284653,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(c5284653.condition)
	e1:SetOperation(c5284653.operation)
	c:RegisterEffect(e1)
end
function c5284653.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local a=Duel.GetAttacker()
	if a==c then a=Duel.GetAttackTarget() end
	e:SetLabelObject(a)
	return a and a:IsType(TYPE_EFFECT) and a:IsRelateToBattle()
end
function c5284653.operation(e,tp,eg,ep,ev,re,r,rp)
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
