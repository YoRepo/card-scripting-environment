--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 星辰的吼炎  (ID: 5431722)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 457
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：以场上1张表侧表示的魔法卡为对象才能发动。那张卡的效果直到回合结束时无效。那之后，以下效果可以适用。
-- ●「星辰的吼炎」以外的自己的墓地·除外状态的1张「星辰」卡回到卡组最下面。那之后，自己抽1张。
--[[ __CARD_HEADER_END__ ]]

--星辰の吼炎
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_TODECK+CATEGORY_DRAW+CATEGORY_GRAVE_ACTION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.negfilter(c)
	return aux.NegateAnyFilter(c) and c:IsType(TYPE_SPELL)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and s.negfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.negfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISABLE)
	Duel.SelectTarget(tp,s.negfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
end
function s.tdfilter(c)
	return c:IsFaceupEx() and not c:IsCode(id) and c:IsSetCard(0x1c9) and c:IsAbleToDeck()
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and tc:IsCanBeDisabledByEffect(e,false) then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		tc:RegisterEffect(e2)
		Duel.AdjustInstantly()
		if Duel.IsExistingMatchingCard(aux.NecroValleyFilter(s.tdfilter),tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil)
			and Duel.IsPlayerCanDraw(tp,1)
			and Duel.SelectYesNo(tp,aux.Stringid(id,1)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
			local sg=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.tdfilter),tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil)
			local dtc=sg:GetFirst()
			if dtc then
				Duel.BreakEffect()
				Duel.HintSelection(sg)
				if Duel.SendtoDeck(dtc,nil,SEQ_DECKBOTTOM,REASON_EFFECT)>0 and dtc:IsLocation(LOCATION_DECK+LOCATION_EXTRA) then
					Duel.BreakEffect()
					Duel.Draw(tp,1,REASON_EFFECT)
				end
			end
		end
	end
end
