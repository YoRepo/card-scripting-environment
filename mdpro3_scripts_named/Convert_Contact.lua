--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 转变接触  (ID: 82639107)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己场上没有怪兽存在的场合才能发动。从手卡以及卡组把「新空间侠」卡各1张送去墓地。那之后，自己从卡组抽2张。
--[[ __CARD_HEADER_END__ ]]

--コンバート・コンタクト
function c82639107.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c82639107.condition)
	e1:SetTarget(c82639107.target)
	e1:SetOperation(c82639107.activate)
	c:RegisterEffect(e1)
end
function c82639107.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c82639107.filter(c)
	return c:IsSetCard(0x1f) and c:IsAbleToGrave()
end
function c82639107.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2)
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=3
		and Duel.IsExistingMatchingCard(c82639107.filter,tp,LOCATION_HAND,0,1,nil)
		and Duel.IsExistingMatchingCard(c82639107.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c82639107.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(c82639107.filter,tp,LOCATION_HAND,0,nil)
	local g2=Duel.GetMatchingGroup(c82639107.filter,tp,LOCATION_DECK,0,nil)
	if g1:GetCount()>0 and g2:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg1=g1:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg2=g2:Select(tp,1,1,nil)
		sg1:Merge(sg2)
		if Duel.SendtoGrave(sg1,REASON_EFFECT)>0 and sg1:IsExists(Card.IsLocation,1,nil,LOCATION_GRAVE) then
			Duel.ShuffleDeck(tp)
			Duel.BreakEffect()
			Duel.Draw(tp,2,REASON_EFFECT)
		end
	end
end
