--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 元素英雄 豪勇新宇侠  (ID: 64655485)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Warrior
-- Level 7
-- ATK 2500 | DEF 2000
-- Setcode: 602120
--
-- Effect Text:
-- 「元素英雄 新宇侠」＋4星以下的效果怪兽
-- 这张卡不用融合召唤不能特殊召唤。
-- ①：这张卡的攻击力上升自己墓地的「新空间侠」怪兽以及「英雄」怪兽数量×100。
-- ②：这张卡战斗破坏对方怪兽时才能发动。把有「元素英雄 新宇侠」的卡名记述的1张魔法·陷阱卡从卡组加入手卡。
--[[ __CARD_HEADER_END__ ]]

--E・HERO ブレイヴ・ネオス
function c64655485.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,89943723,c64655485.ffilter,1,true,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c64655485.atkval)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(64655485,0))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetCondition(aux.bdocon)
	e3:SetTarget(c64655485.thtg)
	e3:SetOperation(c64655485.thop)
	c:RegisterEffect(e3)
end
c64655485.material_setcode=0x8
function c64655485.ffilter(c)
	return c:IsLevelBelow(4) and c:IsFusionType(TYPE_EFFECT)
end
function c64655485.atkfilter(c)
	return c:IsSetCard(0x8,0x1f) and c:IsType(TYPE_MONSTER)
end
function c64655485.atkval(e,c)
	return Duel.GetMatchingGroupCount(c64655485.atkfilter,c:GetControler(),LOCATION_GRAVE,0,nil)*100
end
function c64655485.thfilter(c)
	return aux.IsCodeListed(c,89943723) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c64655485.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c64655485.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c64655485.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c64655485.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
