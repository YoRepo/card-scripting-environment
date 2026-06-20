--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 恶魔喜剧演员  (ID: 81172176)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：进行1次投掷硬币，对硬币的里表作猜测。猜中的场合，对方墓地的卡全部除外。猜错的场合，把对方墓地的卡数量的卡从自己卡组上面送去墓地。
--[[ __CARD_HEADER_END__ ]]

--デビル・コメディアン
function c81172176.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_COIN+CATEGORY_REMOVE+CATEGORY_DECKDES+CATEGORY_GRAVE_ACTION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c81172176.target)
	e1:SetOperation(c81172176.activate)
	c:RegisterEffect(e1)
end
function c81172176.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,nil)
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=Duel.GetFieldGroupCount(tp,0,LOCATION_GRAVE) end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c81172176.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_COIN)
	local coin=Duel.AnnounceCoin(tp)
	local res=Duel.TossCoin(tp,1)
	if coin~=res then Duel.Remove(Duel.GetFieldGroup(tp,0,LOCATION_GRAVE),POS_FACEUP,REASON_EFFECT)
	else Duel.DiscardDeck(tp,Duel.GetFieldGroupCount(tp,0,LOCATION_GRAVE),REASON_EFFECT) end
end
