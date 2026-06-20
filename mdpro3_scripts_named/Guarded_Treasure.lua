--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 守护神的宝札  (ID: 17052477)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：丢弃5张手卡才能把这张卡发动。自己从卡组抽2张。
-- ②：只要这张卡在魔法与陷阱区域存在，自己抽卡阶段的通常抽卡变成2张。
--[[ __CARD_HEADER_END__ ]]

--守護神の宝札
function c17052477.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c17052477.cost)
	e1:SetTarget(c17052477.target)
	e1:SetOperation(c17052477.operation)
	c:RegisterEffect(e1)
	--Effect Draw
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DRAW_COUNT)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(1,0)
	e2:SetValue(2)
	c:RegisterEffect(e2)
end
function c17052477.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,5,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,5,5,REASON_COST+REASON_DISCARD)
end
function c17052477.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c17052477.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
