--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 海造贼-蓝胡子海技士  (ID: 55349375)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fiend
-- Level 4
-- ATK 500 | DEF 1000
-- Setcode: 319
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己场上有「海造贼-蓝胡子海技士」以外的「海造贼」怪兽存在的场合才能发动。这张卡从手卡特殊召唤。
-- ②：这张卡从手卡·怪兽区域送去墓地的场合，丢弃1张手卡才能发动。自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--海造賊－青髭の海技士
function c55349375.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(55349375,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,55349375)
	e1:SetCondition(c55349375.spcon)
	e1:SetTarget(c55349375.sptg)
	e1:SetOperation(c55349375.spop)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(55349375,1))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,55349376)
	e2:SetCondition(c55349375.drcon)
	e2:SetCost(c55349375.drcost)
	e2:SetTarget(c55349375.drtg)
	e2:SetOperation(c55349375.drop)
	c:RegisterEffect(e2)
end
function c55349375.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x13f) and not c:IsCode(55349375)
end
function c55349375.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c55349375.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c55349375.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c55349375.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c55349375.drcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) or c:IsPreviousLocation(LOCATION_HAND)
end
function c55349375.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD,nil)
end
function c55349375.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c55349375.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
