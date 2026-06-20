--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 妒绝之咒眼  (ID: 6494106)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 297
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：自己场上有「咒眼」怪兽存在的场合，以场上1只怪兽为对象才能发动。那只怪兽回到持有者手卡。自己的魔法与陷阱区域有「太阴之咒眼」存在的场合，这个效果的对象可以变成2只。
--[[ __CARD_HEADER_END__ ]]

--妬絶の呪眼
function c6494106.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,6494106+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c6494106.condition)
	e1:SetTarget(c6494106.target)
	e1:SetOperation(c6494106.activate)
	c:RegisterEffect(e1)
end
function c6494106.filter(c)
	return c:IsSetCard(0x129) and c:IsFaceup()
end
function c6494106.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c6494106.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c6494106.filter1(c)
	return c:IsFaceup() and c:IsCode(44133040)
end
function c6494106.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsAbleToHand() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToHand,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local tg=1
	if Duel.IsExistingMatchingCard(c6494106.filter1,tp,LOCATION_SZONE,0,1,nil) then
		tg=2
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,LOCATION_MZONE,LOCATION_MZONE,1,tg,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,#g,0,0)
end
function c6494106.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.SendtoHand(sg,nil,REASON_EFFECT)
end
