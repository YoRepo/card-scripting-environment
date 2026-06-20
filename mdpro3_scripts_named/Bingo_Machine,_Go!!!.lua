--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 摇号机GO！GO！  (ID: 93437091)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从卡组选以下的卡合计3张给对方观看，对方从那之中随机选1张。那1张卡加入自己手卡，剩下的卡回到卡组。
-- ●「青眼」怪兽
-- ●除「摇号机GO！GO！」外的有「青眼白龙」「青眼究极龙」其中任意种的卡名记述的魔法·陷阱卡
--[[ __CARD_HEADER_END__ ]]

--ビンゴマシーンGO！GO！
function c93437091.initial_effect(c)
	aux.AddCodeList(c,89631139,23995346)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,93437091+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c93437091.thtg)
	e1:SetOperation(c93437091.thop)
	c:RegisterEffect(e1)
end
function c93437091.thfilter(c)
	return (((aux.IsCodeListed(c,89631139) or aux.IsCodeListed(c,23995346)) and not c:IsCode(93437091) and c:IsType(TYPE_SPELL+TYPE_TRAP))
		or (c:IsSetCard(0xdd) and c:IsType(TYPE_MONSTER))) and c:IsAbleToHand()
end
function c93437091.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c93437091.thfilter,tp,LOCATION_DECK,0,3,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c93437091.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c93437091.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>=3 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,3,3,nil)
		Duel.ConfirmCards(1-tp,sg)
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ATOHAND)
		local tg=sg:RandomSelect(1-tp,1)
		Duel.ShuffleDeck(tp)
		tg:GetFirst():SetStatus(STATUS_TO_HAND_WITHOUT_CONFIRM,true)
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
	end
end
