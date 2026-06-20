--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 魔玩具·剪刀狼  (ID: 11039171)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Fiend
-- Level 6
-- ATK 2000 | DEF 1500
-- Setcode: 173
--
-- Effect Text:
-- 「锋利小鬼·剪刀」＋「毛绒动物」怪兽1只以上
-- 这张卡用以上记的卡为融合素材的融合召唤才能特殊召唤。
-- ①：这张卡在同1次的战斗阶段中可以作出最多有作为这张卡的融合素材的怪兽数量的攻击。
--[[ __CARD_HEADER_END__ ]]

--デストーイ・シザー・ウルフ
function c11039171.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFunRep(c,30068120,aux.FilterBoolFunction(Card.IsFusionSetCard,0xa9),1,127,false,false)
	--spsummon condition
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetValue(aux.fuslimit)
	c:RegisterEffect(e2)
	--multi
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetOperation(c11039171.atkop)
	c:RegisterEffect(e3)
end
function c11039171.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(c:GetMaterialCount()-1)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
	c:RegisterEffect(e1)
end
