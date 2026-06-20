--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 鬼哥布林  (ID: 42541548)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fiend
-- Level 4
-- ATK 1200 | DEF 1500
-- Setcode: 172
--
-- Effect Text:
-- 只要这张卡在自己场上以表侧表示存在，在自己回合的结束阶段时，可以将1张通常怪兽卡从手卡放回卡组最下方，再从卡组抽1张卡。此效果每回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--鬼ゴブリン
function c42541548.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(42541548,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c42541548.drcon)
	e1:SetCost(c42541548.drcost)
	e1:SetTarget(c42541548.drtg)
	e1:SetOperation(c42541548.drop)
	c:RegisterEffect(e1)
end
function c42541548.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c42541548.cfilter(c)
	return c:IsType(TYPE_NORMAL) and c:IsAbleToDeckAsCost()
end
function c42541548.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c42541548.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c42541548.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.SendtoDeck(g,nil,SEQ_DECKBOTTOM,REASON_COST)
end
function c42541548.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c42541548.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown() then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
