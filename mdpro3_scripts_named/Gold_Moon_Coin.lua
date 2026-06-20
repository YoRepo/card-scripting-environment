--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 星星金币  (ID: 43528009)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：选自己2张手卡加入对方手卡。那之后，自己从卡组抽2张。
--[[ __CARD_HEADER_END__ ]]

--星の金貨
function c43528009.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,43528009+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c43528009.target)
	e1:SetOperation(c43528009.activate)
	c:RegisterEffect(e1)
end
function c43528009.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_HAND,0,2,e:GetHandler()) and Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c43528009.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(43528009,0))
	local ag=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_HAND,0,2,2,nil)
	if ag:GetCount()==2 then
		Duel.SendtoHand(ag,1-tp,REASON_EFFECT)
		Duel.ConfirmCards(tp,ag)
		Duel.ShuffleHand(tp)
		Duel.ShuffleHand(1-tp)
		Duel.BreakEffect()
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end
