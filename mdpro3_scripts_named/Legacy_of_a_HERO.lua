--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 英雄的遗产  (ID: 25614410)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 8
--
-- Effect Text:
-- 「英雄的遗产」在1回合只能发动1张。
-- ①：让需以「英雄」怪兽为融合素材的2只融合怪兽从自己墓地回到额外卡组才能发动。自己从卡组抽3张。
--[[ __CARD_HEADER_END__ ]]

--HEROの遺産
function c25614410.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCountLimit(1,25614410+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c25614410.cost)
	e1:SetTarget(c25614410.target)
	e1:SetOperation(c25614410.activate)
	c:RegisterEffect(e1)
end
function c25614410.cfilter(c)
	return aux.IsMaterialListSetCard(c,0x8) and c:IsType(TYPE_FUSION) and c:IsAbleToExtraAsCost()
end
function c25614410.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c25614410.cfilter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c25614410.cfilter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_COST)
end
function c25614410.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,3) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(3)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,3)
end
function c25614410.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
