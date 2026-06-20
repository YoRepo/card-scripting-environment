--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 幻变骚灵·像素妖精  (ID: 57769391)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Spellcaster
-- Level 1
-- ATK 100 | DEF 100
-- Setcode: 259
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：把这张卡解放才能发动。从自己卡组上面把3张卡翻开，从那之中选1张「幻变骚灵」卡加入手卡，剩下的卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--オルターガイスト・ピクシール
function c57769391.initial_effect(c)
	--mill
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(57769391,0))
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,57769391)
	e1:SetCost(c57769391.cost)
	e1:SetTarget(c57769391.target)
	e1:SetOperation(c57769391.operation)
	c:RegisterEffect(e1)
end
function c57769391.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c57769391.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,3)
		and Duel.GetDecktopGroup(tp,3):FilterCount(Card.IsAbleToHand,nil)>0 end
end
function c57769391.filter(c)
	return c:IsAbleToHand() and c:IsSetCard(0x103)
end
function c57769391.operation(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanDiscardDeck(tp,3) then return end
	Duel.ConfirmDecktop(tp,3)
	local g=Duel.GetDecktopGroup(tp,3)
	if g:GetCount()>0 then
		Duel.DisableShuffleCheck()
		if g:IsExists(c57769391.filter,1,nil) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=g:FilterSelect(tp,c57769391.filter,1,1,nil)
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
			Duel.ShuffleHand(tp)
			g:Sub(sg)
		end
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_REVEAL)
	end
end
