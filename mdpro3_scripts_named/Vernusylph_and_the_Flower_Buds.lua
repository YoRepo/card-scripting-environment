--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Vernusylph and the Flower Buds  (ID: 63708033)
-- Type: Trap
-- Setcode: 0x182
-- Scope: OCG / TCG
--
-- Effect Text:
-- Target face-up cards your opponent controls, up to the number of EARTH monsters you control with
-- different names that were Special Summoned from the GY; return EARTH monsters you control to the
-- hand equal to the number of targets, and if you returned at least 1 to the hand, return the targeted
-- cards to the hand.
-- You can only activate 1 "Vernusylph and the Flower Buds" per turn.
--[[ __CARD_HEADER_END__ ]]

--春化精と花蕾
function c63708033.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,63708033+EFFECT_COUNT_CODE_OATH)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetTarget(c63708033.target)
	e1:SetOperation(c63708033.activate)
	c:RegisterEffect(e1)
end
function c63708033.cfilter(c)
	return c:IsSummonLocation(LOCATION_GRAVE) and c:IsAttribute(ATTRIBUTE_EARTH) and c:IsFaceup()
end
function c63708033.thfilter(c)
	return c:IsFaceup() and c:IsAbleToHand()
end
function c63708033.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c63708033.thfilter(chkc) end
	local g=Duel.GetMatchingGroup(c63708033.cfilter,tp,LOCATION_MZONE,0,nil)
	if chk==0 then return #g>0 and Duel.IsExistingTarget(c63708033.thfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local ct=g:GetClassCount(Card.GetCode)
	local sg=Duel.SelectTarget(tp,c63708033.thfilter,tp,0,LOCATION_ONFIELD,1,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,sg:GetCount()*2,0,0)
end
function c63708033.sfilter(c)
	return c:IsAttribute(ATTRIBUTE_EARTH) and c:IsFaceup() and c:IsAbleToHand()
end
function c63708033.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg=g:Filter(Card.IsRelateToEffect,nil,e)
	local ct=tg:GetCount()
	local g2=Duel.GetMatchingGroup(c63708033.sfilter,tp,LOCATION_MZONE,0,nil)
	if g2:GetCount()<ct then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local sg=g2:Select(tp,ct,ct,nil)
	if Duel.SendtoHand(sg,nil,REASON_EFFECT)>0 and sg:IsExists(Card.IsLocation,1,nil,LOCATION_HAND) then
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
	end
end
