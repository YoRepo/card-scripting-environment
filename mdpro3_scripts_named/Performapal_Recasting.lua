--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 娱乐伙伴阵容更换  (ID: 71705144)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 159
--
-- Effect Text:
-- 「娱乐伙伴阵容更换」在1回合只能发动1张。
-- ①：把手卡的「娱乐伙伴」怪兽任意数量给对方观看，回到卡组洗切。那之后，自己从卡组抽出回到卡组的数量＋1张。
--[[ __CARD_HEADER_END__ ]]

--EMキャスト・チェンジ
function c71705144.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,71705144+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c71705144.target)
	e1:SetOperation(c71705144.activate)
	c:RegisterEffect(e1)
end
function c71705144.filter(c)
	return c:IsSetCard(0x9f) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeck() and not c:IsPublic()
end
function c71705144.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		and Duel.IsExistingMatchingCard(c71705144.filter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND)
end
function c71705144.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(p,c71705144.filter,p,LOCATION_HAND,0,1,63,nil)
	if g:GetCount()>0 then
		Duel.ConfirmCards(1-p,g)
		local ct=Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
		Duel.ShuffleDeck(p)
		Duel.BreakEffect()
		Duel.Draw(p,ct+1,REASON_EFFECT)
	end
end
