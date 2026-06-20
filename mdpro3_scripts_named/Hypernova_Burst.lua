--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 极超辰醒  (ID: 90384300)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从手卡以及自己场上的表侧表示怪兽之中把2只不能通常召唤的怪兽里侧表示除外才能发动。自己从卡组抽2张。
--[[ __CARD_HEADER_END__ ]]

--極超辰醒
function c90384300.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,90384300+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c90384300.cost)
	e1:SetTarget(c90384300.target)
	e1:SetOperation(c90384300.activate)
	c:RegisterEffect(e1)
end
function c90384300.costfilter(c)
	return (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and c:IsType(TYPE_MONSTER)
		and not c:IsSummonableCard() and c:IsAbleToRemoveAsCost(POS_FACEDOWN)
end
function c90384300.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90384300.costfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c90384300.costfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,2,2,nil)
	local hg=g:Filter(Card.IsLocation,nil,LOCATION_HAND)
	if #hg>0 then Duel.ConfirmCards(1-tp,hg) end
	Duel.Remove(g,POS_FACEDOWN,REASON_COST)
end
function c90384300.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c90384300.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
