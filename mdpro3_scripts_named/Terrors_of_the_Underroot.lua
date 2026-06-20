--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 常世离  (ID: 11110218)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：以对方墓地最多5张卡为对象，并以那个数量的对方的除外状态的卡为对象才能发动。作为对象的墓地的卡除外，作为对象的除外状态的卡回到墓地。
--[[ __CARD_HEADER_END__ ]]

--常世離レ
function c11110218.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCountLimit(1,11110218+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c11110218.target)
	e1:SetOperation(c11110218.activate)
	c:RegisterEffect(e1)
end
function c11110218.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,nil)
		and Duel.IsExistingTarget(Card.IsAbleToGrave,tp,0,LOCATION_REMOVED,1,nil) end
	local rt=Duel.GetTargetCount(aux.TRUE,tp,0,LOCATION_REMOVED,nil)
	if rt>5 then rt=5 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,rt,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=Duel.SelectTarget(tp,Card.IsAbleToGrave,tp,0,LOCATION_REMOVED,#g1,#g1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g1,#g1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g2,#g2,0,0)
end
function c11110218.filter(c,loc,e)
	return c:IsLocation(loc) and c:IsRelateToEffect(e)
end
function c11110218.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg1=g:Filter(c11110218.filter,nil,LOCATION_GRAVE,e)
	local tg2=g:Filter(c11110218.filter,nil,LOCATION_REMOVED,e)
	if Duel.Remove(tg1,POS_FACEUP,REASON_EFFECT)>0 then
		Duel.SendtoGrave(tg2,REASON_EFFECT+REASON_RETURN)
	end
end
