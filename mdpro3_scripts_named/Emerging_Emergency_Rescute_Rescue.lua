--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 紧急救急救命救援  (ID: 97926515)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：自己基本分比对方少的场合才能发动。从卡组把3只攻击力300/守备力100的兽族怪兽给对方观看，对方从那之中选1只。那1只怪兽加入自己手卡，剩余回到卡组。
--[[ __CARD_HEADER_END__ ]]

--緊急救急救命レスキュー
function c97926515.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,97926515+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c97926515.condition)
	e1:SetTarget(c97926515.target)
	e1:SetOperation(c97926515.activate)
	c:RegisterEffect(e1)
end
function c97926515.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<Duel.GetLP(1-tp)
end
function c97926515.thfilter(c)
	return c:IsRace(RACE_BEAST) and c:IsAttack(300) and c:IsDefense(100) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c97926515.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c97926515.thfilter,tp,LOCATION_DECK,0,3,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c97926515.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c97926515.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>=3 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,3,3,nil)
		Duel.ConfirmCards(1-tp,sg)
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ATOHAND)
		local tg=sg:Select(1-tp,1,1,nil)
		tg:GetFirst():SetStatus(STATUS_TO_HAND_WITHOUT_CONFIRM,true)
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
	end
end
