--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 彼岸的诗人 维吉尔  (ID: 601193)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 6
-- ATK 2500 | DEF 1000
-- Setcode: 177
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 「彼岸的诗人 维吉尔」的③的效果1回合只能使用1次。
-- ①：「彼岸的诗人 维吉尔」在自己场上只能有1只表侧表示存在。
-- ②：1回合1次，从手卡丢弃1张「彼岸」卡，以对方的场上·墓地1张卡为对象才能发动。那张卡回到持有者卡组。
-- ③：场上的这张卡被战斗·效果破坏送去墓地的场合才能发动。自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--彼岸の詩人 ウェルギリウス
function c601193.initial_effect(c)
	c:SetUniqueOnField(1,0,601193)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(601193,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c601193.tdcost)
	e1:SetTarget(c601193.tdtg)
	e1:SetOperation(c601193.tdop)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(601193,1))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,601193)
	e2:SetCondition(c601193.drcon)
	e2:SetTarget(c601193.drtg)
	e2:SetOperation(c601193.drop)
	c:RegisterEffect(e2)
end
function c601193.filter(c)
	return c:IsSetCard(0xb1) and c:IsDiscardable()
end
function c601193.tdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c601193.filter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c601193.filter,1,1,REASON_COST+REASON_DISCARD)
end
function c601193.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_ONFIELD+LOCATION_GRAVE) and chkc:IsControler(1-tp) and chkc:IsAbleToDeck() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD+LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=aux.SelectTargetFromFieldFirst(tp,Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD+LOCATION_GRAVE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c601193.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
function c601193.drcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsReason(REASON_DESTROY) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
end
function c601193.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c601193.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
