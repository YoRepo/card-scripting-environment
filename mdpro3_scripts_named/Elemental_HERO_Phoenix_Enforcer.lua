--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 元素英雄 凤凰人  (ID: 41436536)
-- Type: Monster / Effect / Fusion
-- Attribute: FIRE
-- Race: Warrior
-- Level 6
-- ATK 2100 | DEF 1200
-- Setcode: 12296
--
-- Effect Text:
-- 「元素英雄 羽翼侠」＋「元素英雄 爆热女郎」
-- 这只怪兽不能作融合召唤以外的特殊召唤。这张卡不会被战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--E・HERO フェニックスガイ
function c41436536.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,21844576,58932615,true,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
c41436536.material_setcode=0x8
