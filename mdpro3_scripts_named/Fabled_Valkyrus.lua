--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 魔轰神 瓦尔基鲁斯  (ID: 54048462)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Fiend
-- Level 8
-- ATK 2900 | DEF 1700
-- Setcode: 53
--
-- Effect Text:
-- 「魔轰神」调整＋调整以外的怪兽1只以上
-- ①：1回合1次，从手卡丢弃1只恶魔族怪兽才能发动。自己抽1张。
--[[ __CARD_HEADER_END__ ]]

--魔轟神ヴァルキュルス
function c54048462.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x35),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(54048462,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c54048462.cost)
	e1:SetTarget(c54048462.tg)
	e1:SetOperation(c54048462.op)
	c:RegisterEffect(e1)
end
function c54048462.costfilter(c)
	return c:IsRace(RACE_FIEND) and c:IsDiscardable()
end
function c54048462.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c54048462.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c54048462.costfilter,1,1,REASON_DISCARD+REASON_COST)
end
function c54048462.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c54048462.op(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
