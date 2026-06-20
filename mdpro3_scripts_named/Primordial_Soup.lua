--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 原初之液  (ID: 78933589)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 1回合1次，自己的主要阶段时才能发动。让手卡最多2只名字带有「进化龙」的怪兽回到卡组洗切，并从卡组抽出回去数量的卡。「原初之液」在自己场上只能有1张表侧表示存在。
--[[ __CARD_HEADER_END__ ]]

--原初のスープ
function c78933589.initial_effect(c)
	c:SetUniqueOnField(1,0,78933589)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(78933589,0))
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c78933589.target)
	e2:SetOperation(c78933589.activate)
	c:RegisterEffect(e2)
end
function c78933589.filter(c)
	return c:IsSetCard(0x604e) and c:IsAbleToDeck()
end
function c78933589.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		and Duel.IsExistingMatchingCard(c78933589.filter,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c78933589.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or not Duel.IsPlayerCanDraw(tp) then return end
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if ct==0 then return end
	if ct>2 then ct=2 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c78933589.filter,tp,LOCATION_HAND,0,1,ct,nil)
	if g:GetCount()>0 then
		Duel.ConfirmCards(1-tp,g)
		Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
		Duel.ShuffleDeck(tp)
		Duel.BreakEffect()
		Duel.Draw(tp,g:GetCount(),REASON_EFFECT)
	end
end
