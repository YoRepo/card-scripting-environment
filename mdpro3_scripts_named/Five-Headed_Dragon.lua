--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 五神龙  (ID: 99267150)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Dragon
-- Level 12
-- ATK 5000 | DEF 5000
--
-- Effect Text:
-- 龙族怪兽×5
-- 这张卡不用融合召唤不能特殊召唤。
-- ①：这张卡不会被和暗·地·水·炎·风属性怪兽的战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--F・G・D
function c99267150.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsRace,RACE_DRAGON),5,true)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(c99267150.batfilter)
	c:RegisterEffect(e2)
	--spsummon condition
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	e3:SetValue(aux.fuslimit)
	c:RegisterEffect(e3)
end
function c99267150.batfilter(e,c)
	return c:IsAttribute(0x2f)
end
