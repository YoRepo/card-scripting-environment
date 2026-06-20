--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 幻影英雄 三一人  (ID: 46759931)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Warrior
-- Level 8
-- ATK 2500 | DEF 2000
-- Setcode: 20488
--
-- Effect Text:
-- 「英雄」怪兽×3
-- ①：这张卡不能直接攻击。
-- ②：这张卡融合召唤时适用。这张卡的攻击力直到回合结束时变成原本攻击力的2倍。
-- ③：融合召唤的这张卡在同1次的战斗阶段中可以作3次攻击。
--[[ __CARD_HEADER_END__ ]]

--V・HERO トリニティー
function c46759931.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x8),3,true)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c46759931.regcon)
	e1:SetOperation(c46759931.regop)
	c:RegisterEffect(e1)
	--extra attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK)
	e2:SetCondition(c46759931.atkcon)
	e2:SetValue(2)
	c:RegisterEffect(e2)
	--cannot diratk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	c:RegisterEffect(e3)
end
c46759931.material_setcode=0x8
function c46759931.regcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c46759931.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
	e1:SetValue(c:GetBaseAttack()*2)
	c:RegisterEffect(e1)
end
function c46759931.atkcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
