--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 异热同心构筑  (ID: 62623659)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 126
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：把1张手卡给对方观看，从卡组把以下的卡之内任意1张加入手卡。那之后，给人观看的卡回到卡组。
-- ●「异热同心武器」怪兽
-- ●「异热同心从者」怪兽
-- ●「异热同心」魔法·陷阱卡
-- ●「升阶魔法」魔法卡
-- ●「降阶魔法」魔法卡
--[[ __CARD_HEADER_END__ ]]

--ゼアル・コンストラクション
function c62623659.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(62623659,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,62623659+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c62623659.target)
	e1:SetOperation(c62623659.activate)
	c:RegisterEffect(e1)
end
function c62623659.filter(c)
	return ((c:IsSetCard(0x107e,0x207e) and c:IsType(TYPE_MONSTER))
		or (c:IsSetCard(0x7e) and c:IsType(TYPE_SPELL+TYPE_TRAP))
		or (c:IsSetCard(0x95,0x15e) and c:IsType(TYPE_SPELL))) and c:IsAbleToHand()
end
function c62623659.tdfilter(c)
	return not c:IsPublic() and c:IsAbleToDeck()
end
function c62623659.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c62623659.filter,tp,LOCATION_DECK,0,1,nil)
		and Duel.IsExistingMatchingCard(c62623659.tdfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c62623659.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c62623659.tdfilter,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.ConfirmCards(1-tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g1=Duel.SelectMatchingCard(tp,c62623659.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g1:GetCount()~=0 then
		Duel.SendtoHand(g1,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g1)
		Duel.BreakEffect()
		Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	else
		Duel.ShuffleHand(tp)
	end
end
