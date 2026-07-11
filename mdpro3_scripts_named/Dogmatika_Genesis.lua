--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Dogmatika Genesis  (ID: 56588755)
-- Type: Trap
-- Setcode: 0x145
-- Scope: OCG / TCG
--
-- Effect Text:
-- Target 1 banished Fusion, Synchro, Xyz, or Link Monster, and 1 Effect Monster your opponent controls
-- of the same type (Fusion, Synchro, Xyz, or Link); return that banished monster to the Extra Deck,
-- and if you do, negate the effects of that monster your opponent controls.
-- You can only activate 1 "Dogmatika Genesis" per turn.
--[[ __CARD_HEADER_END__ ]]

--ドラグマ・ジェネシス
function c56588755.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOEXTRA+CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCountLimit(1,56588755+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c56588755.target)
	e1:SetOperation(c56588755.activate)
	c:RegisterEffect(e1)
end
function c56588755.filter(c,tp)
	local ctype=bit.band(c:GetType(),TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ+TYPE_LINK)
	return c:IsFaceup() and ctype~=0 and c:IsAbleToExtra()
		and Duel.IsExistingTarget(c56588755.filter2,tp,0,LOCATION_MZONE,1,nil,ctype)
end
function c56588755.filter2(c,ctype)
	return c:IsType(ctype) and aux.NegateEffectMonsterFilter(c)
end
function c56588755.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c56588755.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c56588755.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,1,nil,tp)
	local ctype=bit.band(g:GetFirst():GetType(),TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ+TYPE_LINK)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISABLE)
	local dg=Duel.SelectTarget(tp,c56588755.filter2,tp,0,LOCATION_MZONE,1,1,nil,ctype)
	e:SetLabelObject(g:GetFirst())
	Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,dg,1,0,0)
end
function c56588755.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg=g:Filter(Card.IsRelateToEffect,nil,e)
	local tc1=e:GetLabelObject()
	local tc2=g:GetFirst()
	if tc1==tc2 then tc2=g:GetNext() end
	if tc1:IsRelateToEffect(e) and Duel.SendtoDeck(tc1,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)~=0 and tc1:IsLocation(LOCATION_EXTRA) then
		if tc2:IsRelateToEffect(e) and tc2:IsFaceup() and tc2:IsControler(1-tp) and not tc2:IsDisabled() then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc2:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc2:RegisterEffect(e2)
		end
	end
end
