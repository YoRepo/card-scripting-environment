--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 宝石骑士·紫晶  (ID: 71616908)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Aqua
-- Level 7
-- ATK 1950 | DEF 2450
-- Setcode: 4167
--
-- Effect Text:
-- 「宝石骑士」怪兽＋水族怪兽
-- 这张卡用融合召唤才能从额外卡组特殊召唤。
-- ①：这张卡从场上送去墓地的场合发动。场上的里侧表示的魔法·陷阱卡全部回到手卡。
--[[ __CARD_HEADER_END__ ]]

--ジェムナイト・アメジス
function c71616908.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x1047),aux.FilterBoolFunction(Card.IsRace,RACE_AQUA),true)
	--spsummon condition
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetValue(c71616908.splimit)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(71616908,0))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c71616908.thcon)
	e3:SetTarget(c71616908.thtg)
	e3:SetOperation(c71616908.thop)
	c:RegisterEffect(e3)
end
function c71616908.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA) or bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c71616908.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c71616908.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,LOCATION_SZONE,LOCATION_SZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c71616908.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,LOCATION_SZONE,LOCATION_SZONE,nil)
	Duel.SendtoHand(g,nil,REASON_EFFECT)
end
