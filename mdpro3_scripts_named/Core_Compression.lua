--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 核心浓度压缩  (ID: 13997673)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 把手卡1张「核成兽的钢核」给对方观看，从手卡丢弃1只名字带有「核成」的怪兽发动。从自己卡组抽2张卡。
--[[ __CARD_HEADER_END__ ]]

--コア濃度圧縮
function c13997673.initial_effect(c)
	aux.AddCodeList(c,36623431)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c13997673.cost)
	e1:SetTarget(c13997673.target)
	e1:SetOperation(c13997673.activate)
	c:RegisterEffect(e1)
end
function c13997673.cfilter1(c)
	return c:IsCode(36623431) and not c:IsPublic()
end
function c13997673.cfilter2(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x1d) and c:IsDiscardable()
end
function c13997673.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13997673.cfilter1,tp,LOCATION_HAND,0,1,nil)
		and Duel.IsExistingMatchingCard(c13997673.cfilter2,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g1=Duel.SelectMatchingCard(tp,c13997673.cfilter1,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g2=Duel.SelectMatchingCard(tp,c13997673.cfilter2,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g2,REASON_COST+REASON_DISCARD)
	Duel.ShuffleHand(tp)
end
function c13997673.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c13997673.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
