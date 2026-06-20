--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 假面英雄 雾水  (ID: 10920352)
-- Type: Monster / Effect / Fusion
-- Attribute: WATER
-- Race: Warrior
-- Level 6
-- ATK 2400 | DEF 2000
-- Setcode: 40968
--
-- Effect Text:
-- 这张卡用「假面变化」的效果才能特殊召唤。这张卡不会被魔法·陷阱·效果怪兽的效果破坏。
--[[ __CARD_HEADER_END__ ]]

--M・HERO ヴェイパー
function c10920352.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.MaskChangeLimit)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
