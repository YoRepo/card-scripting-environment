--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:29
-- Card: 元素英雄 泥球侠  (ID: 52031567)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Warrior
-- Level 6
-- ATK 1900 | DEF 3000
-- Setcode: 12296
--
-- Effect Text:
-- 「元素英雄 水泡侠」＋「元素英雄 黏土侠」
-- 这只怪兽不能作融合召唤以外的特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--E・HERO マッドボールマン
function c52031567.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,79979666,84327329,true,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
end
c52031567.material_setcode=0x8
