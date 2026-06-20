--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 天地开辟  (ID: 32360466)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从卡组把包含「混沌战士」怪兽或者「暗黑骑士 盖亚」怪兽1只以上的3只战士族怪兽给对方观看，对方从那之中随机选1只。那是「混沌战士」怪兽或者「暗黑骑士
-- 盖亚」怪兽的场合，那只怪兽加入自己手卡，剩下的卡全部送去墓地。不是的场合，给对方观看的卡全部送去墓地。
--[[ __CARD_HEADER_END__ ]]

--天地開闢
function c32360466.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCountLimit(1,32360466+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c32360466.target)
	e1:SetOperation(c32360466.activate)
	c:RegisterEffect(e1)
end
function c32360466.filter1(c)
	return c:IsRace(RACE_WARRIOR) and c:IsAbleToHand()
end
function c32360466.filter2(c)
	return c:IsSetCard(0x10cf,0xbd)
end
function c32360466.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if not Duel.IsPlayerCanDiscardDeck(tp,1) then return false end
		local g=Duel.GetMatchingGroup(c32360466.filter1,tp,LOCATION_DECK,0,nil)
		return g:GetCount()>2 and g:IsExists(c32360466.filter2,1,nil)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,LOCATION_DECK)
end
function c32360466.activate(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	local g=Duel.GetMatchingGroup(c32360466.filter1,tp,LOCATION_DECK,0,nil)
	if g:IsExists(c32360466.filter2,1,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg1=g:FilterSelect(tp,c32360466.filter2,1,1,nil)
		g:RemoveCard(sg1:GetFirst())
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg2=g:Select(tp,2,2,nil)
		sg1:Merge(sg2)
		Duel.ConfirmCards(1-tp,sg1)
		Duel.ShuffleDeck(tp)
		local tg=sg1:Select(1-tp,1,1,nil)
		local tc=tg:GetFirst()
		Duel.Hint(HINT_CARD,0,tc:GetCode())
		if c32360466.filter2(tc) and tc:IsAbleToHand() then
			tc:SetStatus(STATUS_TO_HAND_WITHOUT_CONFIRM,true)
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			sg1:RemoveCard(tc)
		end
		Duel.SendtoGrave(sg1,REASON_EFFECT)
	end
end
