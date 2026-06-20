--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 魔玩具·冒失鬼  (ID: 91034681)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Fiend
-- Level 8
-- ATK 3000 | DEF 2200
-- Setcode: 173
--
-- Effect Text:
-- 「锋利小鬼」怪兽＋「毛绒动物」怪兽
-- 「魔玩具·冒失鬼」的②的效果1回合只能使用1次。
-- ①：这张卡战斗破坏对方怪兽时才能发动。给与对方1000伤害。
-- ②：表侧表示的这张卡因对方的效果从场上离开的场合或者被战斗破坏的场合才能发动。给与对方为自己墓地的「魔玩具」怪兽数量×500伤害。
--[[ __CARD_HEADER_END__ ]]

--デストーイ・デアデビル
function c91034681.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0xc3),aux.FilterBoolFunction(Card.IsFusionSetCard,0xa9),true)
	--damage after destroying
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(91034681,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCondition(aux.bdocon)
	e1:SetTarget(c91034681.damtg1)
	e1:SetOperation(c91034681.damop1)
	c:RegisterEffect(e1)
	--damage after destruction
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(91034681,1))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCountLimit(1,91034681)
	e2:SetCondition(c91034681.damcon2)
	e2:SetTarget(c91034681.damtg2)
	e2:SetOperation(c91034681.damop2)
	c:RegisterEffect(e2)
end
function c91034681.damtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c91034681.damop1(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c91034681.damcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return (c:IsReason(REASON_BATTLE) or (c:GetReasonPlayer()==1-tp and c:IsReason(REASON_EFFECT)))
		and c:IsPreviousPosition(POS_FACEUP)
end
function c91034681.damfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0xad)
end
function c91034681.damtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local gc=Duel.GetMatchingGroupCount(c91034681.damfilter,tp,LOCATION_GRAVE,0,nil)
	if chk==0 then return gc>0 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,gc*500)
end
function c91034681.damop2(e,tp,eg,ep,ev,re,r,rp)
	local gc=Duel.GetMatchingGroupCount(c91034681.damfilter,tp,LOCATION_GRAVE,0,nil)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Damage(p,gc*500,REASON_EFFECT)
end
