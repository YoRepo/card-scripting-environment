--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 青眼双爆裂龙  (ID: 2129638)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Dragon
-- Level 10
-- ATK 3000 | DEF 2500
-- Setcode: 221
--
-- Effect Text:
-- 「青眼白龙」＋「青眼白龙」
-- 这张卡用融合召唤以及以下方法才能特殊召唤。
-- ●把自己的怪兽区域的上记的卡送去墓地的场合可以从额外卡组特殊召唤。
-- ①：这张卡不会被战斗破坏。
-- ②：这张卡在同1次的战斗阶段中最多2次可以向怪兽攻击。
-- ③：这张卡的攻击没让对方怪兽被破坏的伤害步骤结束时才能发动。那只对方怪兽除外。
--[[ __CARD_HEADER_END__ ]]

--青眼の双爆裂龍
function c2129638.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,89631139,2,true,true)
	aux.AddContactFusionProcedure(c,Card.IsAbleToGraveAsCost,LOCATION_MZONE,0,Duel.SendtoGrave,REASON_COST)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c2129638.splimit)
	c:RegisterEffect(e1)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--attack twice
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	--remove
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(2129638,0))
	e7:SetCategory(CATEGORY_REMOVE)
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e7:SetCode(EVENT_DAMAGE_STEP_END)
	e7:SetCondition(c2129638.rmcon)
	e7:SetTarget(c2129638.rmtg)
	e7:SetOperation(c2129638.rmop)
	c:RegisterEffect(e7)
end
function c2129638.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c2129638.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	e:SetLabelObject(bc)
	return c==Duel.GetAttacker() and aux.dsercon(e,tp,eg,ep,ev,re,r,rp)
		and bc and c:IsStatus(STATUS_OPPO_BATTLE) and bc:IsOnField() and bc:IsRelateToBattle()
end
function c2129638.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetLabelObject():IsAbleToRemove() end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetLabelObject(),1,0,0)
end
function c2129638.rmop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetLabelObject()
	if bc:IsRelateToBattle() then
		Duel.Remove(bc,POS_FACEUP,REASON_EFFECT)
	end
end
