--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 元素英雄 水手侠  (ID: 14225239)
-- Type: Monster / Effect / Fusion
-- Attribute: WATER
-- Race: Warrior
-- Level 5
-- ATK 1400 | DEF 1000
-- Setcode: 12296
--
-- Effect Text:
-- 「元素英雄 水泡侠」＋「元素英雄 羽翼侠」
-- 这只怪兽不用融合召唤不能特殊召唤。自己的魔法与陷阱卡区域有卡盖放的场合，这张卡可以直接攻击对方玩家。
--[[ __CARD_HEADER_END__ ]]

--E・HERO セイラーマン
function c14225239.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,79979666,21844576,true,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--direct attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DIRECT_ATTACK)
	e2:SetCondition(c14225239.dacon)
	c:RegisterEffect(e2)
end
c14225239.material_setcode=0x8
function c14225239.filter(c)
	return c:IsFacedown() and c:GetSequence()~=5
end
function c14225239.dacon(e)
	return Duel.IsExistingMatchingCard(c14225239.filter,e:GetHandlerPlayer(),LOCATION_SZONE,0,1,nil)
end
