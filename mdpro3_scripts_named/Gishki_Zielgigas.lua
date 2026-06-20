--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 邪遗式魂魄巨灵  (ID: 66729231)
-- Type: Monster / Effect / Ritual
-- Attribute: WATER
-- Race: Aqua
-- Level 10
-- ATK 3200 | DEF 0
-- Setcode: 58
--
-- Effect Text:
-- 名字带有「遗式」的仪式魔法卡降临。1回合1次，支付1000基本分才能发动。从卡组抽1张卡，给双方确认。确认的卡是名字带有「遗式」的怪兽的场合，场上1张卡回到持有者卡组。
--[[ __CARD_HEADER_END__ ]]

--イビリチュア・ジールギガス
function c66729231.initial_effect(c)
	c:EnableReviveLimit()
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66729231,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c66729231.cost)
	e1:SetTarget(c66729231.target)
	e1:SetOperation(c66729231.operation)
	c:RegisterEffect(e1)
end
function c66729231.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c66729231.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c66729231.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Draw(tp,1,REASON_EFFECT)==0 then return end
	local tc=Duel.GetOperatedGroup():GetFirst()
	Duel.ConfirmCards(1-tp,tc)
	if tc:IsSetCard(0x3a) and tc:IsType(TYPE_MONSTER) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local dg=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
		Duel.SendtoDeck(dg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
	Duel.ShuffleHand(tp)
end
