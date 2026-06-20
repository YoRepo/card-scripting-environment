--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 古生代化石龙 骷髅屠魔龙  (ID: 21225115)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Rock
-- Level 8
-- ATK 3500 | DEF 0
-- Setcode: 329
--
-- Effect Text:
-- 岩石族怪兽＋对方墓地的7星以上的怪兽
-- 这张卡用「化石融合」的效果才能从额外卡组特殊召唤。
-- ①：这张卡和对方怪兽进行战斗的伤害计算前才能发动。那只对方怪兽的攻击力和守备力直到那次伤害步骤结束时交换。
-- ②：这张卡向守备表示怪兽攻击的场合，给与攻击力超过那个守备力的数值的战斗伤害。
-- ③：融合召唤的这张卡和对方怪兽的战斗给与对方的战斗伤害变成2倍。
--[[ __CARD_HEADER_END__ ]]

--古生代化石竜 スカルギオス
function c21225115.initial_effect(c)
	aux.AddCodeList(c,59419719)
	--fusion summon
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsRace,RACE_ROCK),c21225115.matfilter,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FossilFusionLimit)
	c:RegisterEffect(e1)
	--switch stats
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21225115,0))
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_CONFIRM)
	e2:SetCondition(c21225115.atkcon)
	e2:SetOperation(c21225115.atkop)
	c:RegisterEffect(e2)
	--pierce
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e3)
	--double battle damage
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e4:SetCondition(c21225115.damcon)
	e4:SetValue(aux.ChangeBattleDamage(1,DOUBLE_DAMAGE))
	c:RegisterEffect(e4)
end
function c21225115.matfilter(c,fc)
	return c:IsFusionType(TYPE_MONSTER) and c:IsLevelAbove(7) and c:IsLocation(LOCATION_GRAVE) and c:IsControler(1-fc:GetControler())
end
function c21225115.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle() and bc and bc:IsFaceup() and bc:IsRelateToBattle() and bc:IsDefenseAbove(0)
		and bc:GetAttack()~=bc:GetDefense() and bc:IsControler(1-tp)
end
function c21225115.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if tc:IsFaceup() and tc:IsRelateToBattle() and tc:IsControler(1-tp) then
		local atk=tc:GetAttack()
		local def=tc:GetDefense()
		if atk==def then return end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(def)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e2:SetValue(atk)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e2)
	end
end
function c21225115.damcon(e)
	return e:GetHandler():GetBattleTarget()~=nil and e:GetHandler():GetSummonType()&SUMMON_TYPE_FUSION==SUMMON_TYPE_FUSION
end
