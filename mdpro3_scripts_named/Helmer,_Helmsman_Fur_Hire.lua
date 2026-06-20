--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 空牙团的舵手 赫耳玛  (ID: 67466547)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 3
-- ATK 0 | DEF 2000
-- Setcode: 276
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己主要阶段才能发动。从手卡把「空牙团的舵手 赫耳玛」以外的1只「空牙团」怪兽特殊召唤。
-- ②：这张卡已在怪兽区域存在的状态，自己场上有这张卡以外的「空牙团」怪兽特殊召唤的场合，从手卡丢弃1张「空牙团」卡才能发动。自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--空牙団の舵手 ヘルマー
function c67466547.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(67466547,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1,67466547)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c67466547.sptg)
	e1:SetOperation(c67466547.spop)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(67466547,1))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,67466548)
	e2:SetCondition(c67466547.drcon)
	e2:SetCost(c67466547.drcost)
	e2:SetTarget(c67466547.drtg)
	e2:SetOperation(c67466547.drop)
	c:RegisterEffect(e2)
end
function c67466547.spfilter(c,e,tp)
	return c:IsSetCard(0x114) and not c:IsCode(67466547) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c67466547.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c67466547.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c67466547.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c67466547.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c67466547.cfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x114) and c:IsControler(tp)
end
function c67466547.drcon(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c67466547.cfilter,1,nil,tp)
end
function c67466547.drcfilter(c,e,tp)
	if c:IsLocation(LOCATION_HAND) then
		return c:IsSetCard(0x114) and c:IsDiscardable()
	else
		return e:GetHandler():IsSetCard(0x114) and c:IsAbleToRemoveAsCost() and c:IsHasEffect(53557529,tp)
	end
end
function c67466547.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c67466547.drcfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(tp,c67466547.drcfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	local te=tc:IsHasEffect(53557529,tp)
	if te then
		te:UseCountLimit(tp)
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT+REASON_REPLACE)
	else
		Duel.SendtoGrave(tc,REASON_COST+REASON_DISCARD)
	end
end
function c67466547.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c67466547.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
