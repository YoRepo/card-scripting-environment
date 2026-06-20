--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 太阳交换  (ID: 691925)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：从手卡丢弃1只「光道」怪兽才能发动。自己抽2张。那之后，从自己卡组上面把2张卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--ソーラー・エクスチェンジ
function c691925.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c691925.cost)
	e1:SetTarget(c691925.target)
	e1:SetOperation(c691925.activate)
	c:RegisterEffect(e1)
end
function c691925.costfilter(c)
	return c:IsSetCard(0x38) and c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c691925.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c691925.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c691925.costfilter,1,1,REASON_COST+REASON_DISCARD,nil)
end
function c691925.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) and Duel.IsPlayerCanDiscardDeck(tp,2)
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=4 end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,2)
end
function c691925.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.DiscardDeck(tp,2,REASON_EFFECT)
end
