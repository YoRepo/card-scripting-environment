--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 彼岸的巡礼者 但丁  (ID: 18386170)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Fairy
-- Level 9
-- ATK 2800 | DEF 2500
-- Setcode: 13959345
--
-- Effect Text:
-- 卡名不同的「彼岸」怪兽×3
-- 这张卡不用融合召唤不能特殊召唤。
-- ①：这张卡不会成为对方的效果的对象。
-- ②：1回合1次，把手卡1张「彼岸」卡送去墓地才能发动。自己从卡组抽1张。这个效果在对方回合也能发动。
-- ③：场上的这张卡被对方的效果送去墓地的场合或者被战斗破坏送去墓地的场合才能发动。对方手卡随机选1张送去墓地。
--[[ __CARD_HEADER_END__ ]]

--彼岸の巡礼者 ダンテ
function c18386170.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,c18386170.ffilter,3,true)
	--special summon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCountLimit(1)
	e3:SetCost(c18386170.drcost)
	e3:SetTarget(c18386170.drtg)
	e3:SetOperation(c18386170.drop)
	c:RegisterEffect(e3)
	--handes
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_HANDES)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetCondition(c18386170.hdcon)
	e4:SetTarget(c18386170.hdtg)
	e4:SetOperation(c18386170.hdop)
	c:RegisterEffect(e4)
end
function c18386170.ffilter(c,fc,sub,mg,sg)
	return c:IsFusionSetCard(0xb1) and (not sg or not sg:IsExists(Card.IsFusionCode,1,c,c:GetFusionCode()))
end
function c18386170.cfilter(c)
	return c:IsSetCard(0xb1) and c:IsAbleToGraveAsCost()
end
function c18386170.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c18386170.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c18386170.cfilter,1,1,REASON_COST,nil)
end
function c18386170.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c18386170.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c18386170.hdcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return (rp==1-tp and c:IsReason(REASON_EFFECT) and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_ONFIELD)) or c:IsReason(REASON_BATTLE)
end
function c18386170.hdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,1)
end
function c18386170.hdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()==0 then return end
	local sg=g:RandomSelect(tp,1)
	Duel.SendtoGrave(sg,REASON_EFFECT)
end
