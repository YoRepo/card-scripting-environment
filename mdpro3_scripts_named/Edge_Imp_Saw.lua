--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 锋利小鬼·锯子  (ID: 34688023)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- ATK 500 | DEF 1000
-- Setcode: 195
--
-- Effect Text:
-- 「锋利小鬼·锯子」的效果1回合只能使用1次。
-- ①：这张卡召唤成功时，把手卡1只「毛绒动物」怪兽送去墓地才能发动。自己从卡组抽2张，那之后，选1张手卡回到卡组最上面或者最下面。
--[[ __CARD_HEADER_END__ ]]

--エッジインプ・ソウ
function c34688023.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(34688023,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,34688023)
	e1:SetCost(c34688023.cost)
	e1:SetTarget(c34688023.target)
	e1:SetOperation(c34688023.operation)
	c:RegisterEffect(e1)
end
function c34688023.cfilter(c)
	return c:IsSetCard(0xa9) and c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c34688023.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c34688023.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c34688023.cfilter,1,1,REASON_COST)
end
function c34688023.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c34688023.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Draw(p,d,REASON_EFFECT)<2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.BreakEffect()
		if Duel.SelectOption(tp,aux.Stringid(34688023,1),aux.Stringid(34688023,2))==0 then
			Duel.SendtoDeck(g,nil,SEQ_DECKTOP,REASON_EFFECT)
		else
			Duel.SendtoDeck(g,nil,SEQ_DECKBOTTOM,REASON_EFFECT)
		end
	end
end
