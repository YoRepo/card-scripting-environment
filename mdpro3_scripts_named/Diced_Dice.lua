--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 从骰挑战  (ID: 93078761)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：掷1次骰子，1·6出现的场合，把持有掷骰子效果的1张卡从卡组加入手卡。1·6以外出现的场合，再掷1次骰子，出现数目的以下效果适用。
-- ●1·6：场上的这张卡回到持有者手卡。
-- ●2～5：场上的这张卡回到持有者卡组最上面。
--[[ __CARD_HEADER_END__ ]]

--賽挑戦
function c93078761.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DICE+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCountLimit(1,93078761+EFFECT_COUNT_CODE_OATH)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c93078761.target)
	e1:SetOperation(c93078761.activate)
	c:RegisterEffect(e1)
end
function c93078761.filter(c)
	return c:IsEffectProperty(aux.EffectPropertyFilter(EFFECT_FLAG_DICE)) and c:IsAbleToHand()
end
function c93078761.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c93078761.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c93078761.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local dice1=Duel.TossDice(tp,1)
	if (dice1==1 or dice1==6) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local tc=Duel.SelectMatchingCard(tp,c93078761.filter,tp,LOCATION_DECK,0,1,1,nil):GetFirst()
		if tc then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		end
		return
	elseif c:IsRelateToEffect(e) then
		local dice2=Duel.TossDice(tp,1)
		if (dice2==1 or dice2==6) then
			c:CancelToGrave()
			Duel.SendtoHand(c,nil,REASON_EFFECT)
		elseif dice2>=2 and dice2<=5 then
			c:CancelToGrave()
			Duel.SendtoDeck(c,nil,SEQ_DECKTOP,REASON_EFFECT)
		end
	end
end
