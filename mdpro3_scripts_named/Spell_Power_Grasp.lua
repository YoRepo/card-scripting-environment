--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 魔力掌握  (ID: 75014062)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：以场上1张可以放置魔力指示物的卡为对象才能发动。给那张卡放置1个魔力指示物。那之后，可以从卡组把1张「魔力掌握」加入手卡。
--[[ __CARD_HEADER_END__ ]]

--魔力掌握
function c75014062.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_COUNTER+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,75014062+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c75014062.target)
	e1:SetOperation(c75014062.activate)
	c:RegisterEffect(e1)
end
function c75014062.filter(c)
	return c:IsFaceup() and c:IsCanAddCounter(0x1,1)
end
function c75014062.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c75014062.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c75014062.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_COUNTER)
	Duel.SelectTarget(tp,c75014062.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0x1)
end
function c75014062.tfilter(c)
	return c:IsCode(75014062) and c:IsAbleToHand()
end
function c75014062.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) and tc:AddCounter(0x1,1) then
		local th=Duel.GetFirstMatchingCard(c75014062.tfilter,tp,LOCATION_DECK,0,nil)
		if th and Duel.SelectYesNo(tp,aux.Stringid(75014062,0)) then
			Duel.BreakEffect()
			Duel.SendtoHand(th,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,th)
		end
	end
end
