--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 再机动  (ID: 85775486)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 从自己手卡让1只名字带有「机皇」的怪兽回到卡组发动。选择自己墓地存在的1张名字带有「机皇」的卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--再機動
function c85775486.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c85775486.cost)
	e1:SetTarget(c85775486.target)
	e1:SetOperation(c85775486.activate)
	c:RegisterEffect(e1)
end
function c85775486.cfilter(c)
	return c:IsSetCard(0x13) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeckAsCost()
end
function c85775486.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c85775486.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c85775486.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_COST)
end
function c85775486.filter(c)
	return c:IsSetCard(0x13) and c:IsAbleToHand()
end
function c85775486.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c85775486.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c85775486.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c85775486.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c85775486.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
