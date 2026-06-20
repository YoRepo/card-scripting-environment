--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 龙辉巧流星群  (ID: 84965420)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
-- Setcode: 340
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：自己场上有仪式怪兽存在，对方把怪兽召唤·特殊召唤之际才能发动。那个无效，那些怪兽回到持有者卡组。
--[[ __CARD_HEADER_END__ ]]

--ドライトロン流星群
function c84965420.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON)
	e1:SetCountLimit(1,84965420+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c84965420.condition)
	e1:SetTarget(c84965420.target)
	e1:SetOperation(c84965420.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e2)
end
function c84965420.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_RITUAL)
end
function c84965420.cfilter(c,tp)
	return c:IsSummonPlayer(1-tp) and c:IsAbleToDeck()
end
function c84965420.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c84965420.filter,tp,LOCATION_MZONE,0,1,nil)
		and aux.NegateSummonCondition() and eg:IsExists(c84965420.cfilter,1,nil,tp)
end
function c84965420.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,eg,eg:GetCount(),0,0)
end
function c84965420.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.SendtoDeck(eg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
end
