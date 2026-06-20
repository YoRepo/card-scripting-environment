--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 元素英雄 新星主  (ID: 1945387)
-- Type: Monster / Effect / Fusion
-- Attribute: FIRE
-- Race: Warrior
-- Level 8
-- ATK 2600 | DEF 2100
-- Setcode: 12296
--
-- Effect Text:
-- 「元素英雄」怪兽＋炎属性怪兽
-- 这张卡不用融合召唤不能特殊召唤。
-- ①：这张卡战斗破坏对方怪兽的场合发动。自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--E・HERO ノヴァマスター
function c1945387.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x3008),aux.FilterBoolFunction(Card.IsFusionAttribute,ATTRIBUTE_FIRE),true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1945387,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetCondition(aux.bdocon)
	e2:SetTarget(c1945387.drtg)
	e2:SetOperation(c1945387.drop)
	c:RegisterEffect(e2)
end
c1945387.material_setcode=0x8
function c1945387.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c1945387.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
