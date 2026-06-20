--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 现世与冥界的逆转  (ID: 17484499)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在决斗中只能发动1张。
-- ①：双方墓地的卡各自是15张以上的场合支付1000基本分才能发动。双方玩家各自把自身的卡组和墓地的卡全部交换，那之后卡组洗切。
--[[ __CARD_HEADER_END__ ]]

--現世と冥界の逆転
function c17484499.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_DRAW_PHASE)
	e1:SetCountLimit(1,17484499+EFFECT_COUNT_CODE_DUEL+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c17484499.condition)
	e1:SetCost(c17484499.cost)
	e1:SetOperation(c17484499.activate)
	c:RegisterEffect(e1)
end
function c17484499.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)>=15
		and Duel.GetFieldGroupCount(tp,0,LOCATION_GRAVE)>=15
end
function c17484499.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c17484499.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_GRAVE,LOCATION_GRAVE)
	if aux.NecroValleyNegateCheck(g) then return end
	Duel.SwapDeckAndGrave(tp)
	Duel.SwapDeckAndGrave(1-tp)
end
