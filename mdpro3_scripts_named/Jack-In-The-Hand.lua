--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:29
-- Card: 吓人手中盒  (ID: 51697825)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从卡组把3只卡名不同的1星怪兽给对方观看，对方从那之中选1只加入自身手卡，自己从剩下的怪兽之中选1只加入手卡，剩余回到卡组。
--[[ __CARD_HEADER_END__ ]]

--ジャック・イン・ザ・ハンド
function c51697825.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,51697825+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c51697825.target)
	e1:SetOperation(c51697825.activate)
	c:RegisterEffect(e1)
end
function c51697825.thfilter(c,tp)
	return c:IsLevel(1) and c:IsAbleToHand() and c:IsAbleToHand(1-tp)
end
function c51697825.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c51697825.thfilter,tp,LOCATION_DECK,0,nil,tp)
	if chk==0 then return g:GetClassCount(Card.GetCode)>=3 end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,PLAYER_ALL,LOCATION_DECK)
end
function c51697825.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c51697825.thfilter,tp,LOCATION_DECK,0,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g:SelectSubGroup(tp,aux.dncheck,false,3,3)
	if sg then
		Duel.ConfirmCards(1-tp,sg)
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ATOHAND)
		local oc=sg:Select(1-tp,1,1,nil):GetFirst()
		oc:SetStatus(STATUS_TO_HAND_WITHOUT_CONFIRM,true)
		if Duel.SendtoHand(oc,1-tp,REASON_EFFECT)~=0 and oc:IsLocation(LOCATION_HAND) then
			sg:RemoveCard(oc)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sc=sg:Select(tp,1,1,nil):GetFirst()
			sc:SetStatus(STATUS_TO_HAND_WITHOUT_CONFIRM,true)
			Duel.SendtoHand(sc,tp,REASON_EFFECT)
		end
	end
end
