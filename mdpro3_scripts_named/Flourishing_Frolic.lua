--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 繁华的花笑  (ID: 32887445)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：把自己墓地的「繁华的花笑」的数量＋3张从自己卡组上面翻开。那之中有3种类（怪兽·魔法·陷阱）的卡的场合，选那之内的1张加入手卡，剩下的卡送去墓地。没有的场合，翻开的卡全部回到卡组。
--[[ __CARD_HEADER_END__ ]]

--繁華の花笑み
function c32887445.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_DECKDES+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,32887445+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c32887445.target)
	e1:SetOperation(c32887445.activate)
	c:RegisterEffect(e1)
end
function c32887445.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(Card.IsCode,tp,LOCATION_GRAVE,0,nil,32887445)
	local g=Duel.GetDecktopGroup(tp,ct+3)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,ct+3) and g:FilterCount(Card.IsAbleToHand,nil)>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c32887445.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(Card.IsCode,tp,LOCATION_GRAVE,0,nil,32887445)
	if not Duel.IsPlayerCanDiscardDeck(tp,ct+3) then return end
	Duel.ConfirmDecktop(tp,ct+3)
	local g=Duel.GetDecktopGroup(tp,ct+3)
	if g:IsExists(Card.IsType,1,nil,TYPE_MONSTER) and g:IsExists(Card.IsType,1,nil,TYPE_SPELL) and g:IsExists(Card.IsType,1,nil,TYPE_TRAP) then
		Duel.DisableShuffleCheck()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local tc=g:Select(tp,1,1,nil):GetFirst()
		if tc:IsAbleToHand() then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
			Duel.ShuffleHand(tp)
		else
			Duel.SendtoGrave(tc,REASON_RULE)
		end
		g:RemoveCard(tc)
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_REVEAL)
	else
		Duel.ShuffleDeck(tp)
	end
end
