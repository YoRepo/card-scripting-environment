--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 元素英雄 新宇骑士  (ID: 72926163)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Warrior
-- Level 7
-- ATK 2500 | DEF 1000
-- Setcode: 602120
--
-- Effect Text:
-- 「元素英雄 新宇侠」＋战士族怪兽
-- 这张卡不用融合召唤不能特殊召唤。
-- ①：这张卡的攻击力上升作为这张卡的融合素材的「元素英雄 新宇侠」以外的怪兽的原本攻击力一半的数值。
-- ②：这张卡在同1次的战斗阶段中可以作2次攻击。
-- ③：这张卡的战斗发生的对对方的战斗伤害变成0。
--[[ __CARD_HEADER_END__ ]]

--E・HERO ネオス・ナイト
function c72926163.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,89943723,aux.FilterBoolFunction(Card.IsRace,RACE_WARRIOR),1,true,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(c72926163.valcheck)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c72926163.atkcon)
	e3:SetOperation(c72926163.atkop)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
	--multiatk
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_EXTRA_ATTACK)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	--no battle damage
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_NO_BATTLE_DAMAGE)
	c:RegisterEffect(e5)
end
c72926163.material_setcode=0x8
function c72926163.valcheck(e,c)
	local g=c:GetMaterial()
	local atk=0
	local tc=g:GetFirst()
	if tc:IsCode(89943723) or tc:CheckFusionSubstitute(c) then tc=g:GetNext() end
	if not tc:IsCode(89943723) then
		atk=math.ceil(tc:GetTextAttack()/2)
	end
	e:SetLabel(atk)
end
function c72926163.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c72926163.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local atk=e:GetLabelObject():GetLabel()
	if atk>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
