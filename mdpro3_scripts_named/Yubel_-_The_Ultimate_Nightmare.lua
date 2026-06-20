--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 于贝尔-极度悲伤的魔龙  (ID: 31764700)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: DARK
-- Race: Fiend
-- Level 12
-- ATK 0 | DEF 0
-- Setcode: 421
--
-- Effect Text:
-- 这张卡不能通常召唤，用「于贝尔-被憎恶的骑士」的效果才能特殊召唤。
-- ①：这张卡不会被战斗破坏，这张卡的战斗发生的对自己的战斗伤害变成0。
-- ②：攻击表示的这张卡在和对方怪兽进行战斗的伤害步骤结束时发动。给与对方那只对方怪兽的攻击力数值的伤害，那只怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--ユベル－Das Extremer Traurig Drachen
function c31764700.initial_effect(c)
	c:EnableReviveLimit()
	--battle
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_BATTLED)
	e3:SetOperation(c31764700.batop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(31764700,0))
	e4:SetCategory(CATEGORY_DAMAGE+CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_DAMAGE_STEP_END)
	e4:SetCondition(aux.dsercon)
	e4:SetTarget(c31764700.damtg)
	e4:SetOperation(c31764700.damop)
	e4:SetLabelObject(e3)
	c:RegisterEffect(e4)
	--cannot special summon
	local e5=Effect.CreateEffect(c)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e5)
end
function c31764700.batop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc and c:IsAttackPos() then
		e:SetLabel(bc:GetAttack())
		e:SetLabelObject(bc)
	else
		e:SetLabelObject(nil)
	end
end
function c31764700.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetLabelObject():GetLabelObject()
	if chk==0 then return bc end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetLabelObject():GetLabel())
	if bc:IsRelateToBattle() then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
	end
end
function c31764700.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,e:GetLabelObject():GetLabel(),REASON_EFFECT)
	local bc=e:GetLabelObject():GetLabelObject()
	if bc:IsRelateToBattle() then
		Duel.Destroy(bc,REASON_EFFECT)
	end
end
