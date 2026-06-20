--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 元素英雄 荒野锯齿侠  (ID: 10526791)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Warrior
-- Level 8
-- ATK 2600 | DEF 2300
-- Setcode: 12296
--
-- Effect Text:
-- 「元素英雄 荒野侠」＋「元素英雄 金刃侠」
-- 这张卡不用融合召唤不能特殊召唤。
-- ①：这张卡可以向对方怪兽全部各作1次攻击。
--[[ __CARD_HEADER_END__ ]]

--E・HERO ワイルドジャギーマン
function c10526791.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,86188410,59793705,true,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--attackall
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_ATTACK_ALL)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
c10526791.material_setcode=0x8
